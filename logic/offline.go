package logic

import (
	"container/ring"
	"log"

	"github.com/spf13/viper"
)

var OfflineProcessor *offlineProcessor

func init() {
	OfflineProcessor = newProcessor()
}

type offlineProcessor struct {
	n          int
	recentRing *ring.Ring
	userRing   map[string]*ring.Ring
}

func newProcessor() *offlineProcessor {
	viper.AddConfigPath("../config/config.yaml")
	num := viper.GetInt("offline-num")
	if num == 0 {
		num = 100 // 默认值
	}
	return &offlineProcessor{
		n:          num,
		recentRing: ring.New(num),
		userRing:   make(map[string]*ring.Ring),
	}
}

// Save 保存消息
func (o *offlineProcessor) Save(msg *Message) {
	if msg == nil || msg.Content == "" {
		log.Println("Invalid message")
		return
	}

	log.Println("Saving message:", msg.Content)

	if o.recentRing == nil {
		log.Println("recentRing is nil, initializing")
		o.recentRing = ring.New(o.n)
	}

	o.recentRing.Value = msg
	o.recentRing = o.recentRing.Next()

	for _, nickname := range msg.Ats {
		nickname = nickname[1:]
		r, ok := o.userRing[nickname]
		if !ok {
			log.Println("User ring for", nickname, "not found, initializing")
			r = ring.New(o.n)
			o.userRing[nickname] = r
		}
		r.Value = msg
		o.userRing[nickname] = r.Next()
	}
}

// Send 发送离线消息
func (o *offlineProcessor) Send(user *User) {
	if user == nil {
		log.Println("Invalid user")
		return
	}

	o.recentRing.Do(func(value interface{}) {
		if value != nil {
			user.MessageChannel <- value.(*Message)
		}
	})

	if user.isNew {
		return
	}

	if r, ok := o.userRing[user.NickName]; ok {
		r.Do(func(value interface{}) {
			if value != nil {
				user.MessageChannel <- value.(*Message)
			}
		})
		delete(o.userRing, user.NickName)
	}
}
