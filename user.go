package logic

import (
	"context"
	"errors"
	"fmt"
	"io"
	"regexp"
	"strconv"
	"strings"
	"sync/atomic"
	"time"

	"github.com/golang-jwt/jwt"
	"github.com/spf13/viper"
	"nhooyr.io/websocket"
	"nhooyr.io/websocket/wsjson"
)

var globalUID uint32 = 0

type User struct {
	UID            int           `json:"uid"`
	NickName       string        `json:"nickname"`
	EnterAt        time.Time     `json:"enter_at"`
	Addr           string        `json:"addr"`
	MessageChannel chan *Message `json:"-"`
	Token          string        `json:"token"`

	conn *websocket.Conn

	isNew bool
}

// 系统用户，代表是系统主动发送的消息
var System = &User{}

func NewUser(conn *websocket.Conn, token, nickname, addr string) *User {
	user := &User{
		NickName:       nickname,
		Addr:           addr,
		EnterAt:        time.Now(),
		MessageChannel: make(chan *Message, 32),
		Token:          token,
		conn:           conn,
	}

	if user.Token != "" {
		nickname, err := ParseTokenAndValidate(token)
		if err == nil {
			user.NickName = nickname
		}
	}

	if user.UID == 0 {
		user.UID = int(atomic.AddUint32(&globalUID, 1))
		user.Token = GenToken(user.UID, user.NickName)
		user.isNew = true
	}

	return user
}

func (u *User) SendMessage(ctx context.Context) {
	for msg := range u.MessageChannel {
		wsjson.Write(ctx, u.conn, msg)
	}
}

// CloseMessageChannel 避免 goroutine 泄露
func (u *User) CloseMessageChannel() {
	close(u.MessageChannel)
}

func (u *User) ReceiveMessage(ctx context.Context) error {
	var (
		receiveMsg map[string]string
		err        error
	)
	for {
		err = wsjson.Read(ctx, u.conn, &receiveMsg)
		if err != nil {
			// 判定连接是否关闭了，正常关闭，不认为是错误
			var closeErr websocket.CloseError
			if errors.As(err, &closeErr) {
				return nil
			} else if errors.Is(err, io.EOF) {
				return nil
			}

			return err
		}

		// 内容发送到聊天室
		sendMsg := NewMessage(u, receiveMsg["content"], receiveMsg["send_time"])

		// 解析 content，看看 @ 谁了
		reg := regexp.MustCompile(`@[^\s@]{2,20}`)
		sendMsg.Ats = reg.FindAllString(sendMsg.Content, -1)

		Broadcaster.Broadcast(sendMsg)
	}
}

func GenToken(uid int, nickname string) string {

	viper.SetConfigName("config")    // config file name without extension
	viper.SetConfigType("yaml")      // specify the config file type
	viper.AddConfigPath("../config") // path to look for the config file in

	secret := viper.GetString("token-secret")
	expiryTime := time.Now().Add(time.Hour).Unix()
	// message := fmt.Sprintf("%s%s%d", nickname, secret, uid)
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"nickname": nickname,
		"uid":      uid,
		"exp":      expiryTime,
	})
	tokenstring, err := token.SignedString([]byte(secret))
	if err != nil {
		return ""
	}
	return fmt.Sprintf("%suid%d", tokenstring, uid)
}

func ParseTokenAndValidate(tokenstring string) (string, error) {

	viper.SetConfigName("config")    // config file name without extension
	viper.SetConfigType("yaml")      // specify the config file type
	viper.AddConfigPath("../config") // path to look for the config file in
	secret := viper.GetString("token-secret")

	uidIndex := strings.Index(tokenstring, "uid")
	if uidIndex == -1 {
		return "", fmt.Errorf("uid not found in token")
	}
	uidStr := tokenstring[uidIndex+3:]
	_, err := strconv.Atoi(uidStr)
	if err != nil {
		return "", fmt.Errorf("invalid uid: %v", err)
	}
	tokenreal := tokenstring[:uidIndex]

	token, err := jwt.Parse(tokenreal, func(token *jwt.Token) (interface{}, error) {
		return []byte(secret), nil
	})

	if err != nil {
		if err == jwt.ErrSignatureInvalid {
			return "", fmt.Errorf("invalid signature")
		}
		return "", fmt.Errorf("error parsing token: %v", err)
	}

	if !token.Valid {
		return "", fmt.Errorf("invalid token")
	}

	claims, ok := token.Claims.(jwt.MapClaims)
	if !ok {
		return "", fmt.Errorf("error parsing claims")
	}
	nickname, ok := claims["nickname"].(string)
	if !ok {
		return "", fmt.Errorf("error parsing nickname from claims")
	}
	return nickname, nil

}

// func macSha256(message, secret []byte) []byte {
// 	mac := hmac.New(sha256.New, secret)
// 	mac.Write(message)
// 	return mac.Sum(nil)
// }

// func validateMAC(message, messageMAC, secret []byte) bool {
// 	mac := hmac.New(sha256.New, secret)
// 	mac.Write(message)
// 	expectedMAC := mac.Sum(nil)
// 	return hmac.Equal(messageMAC, expectedMAC)
// }
