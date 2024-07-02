package server

import (
	"chatroom_version1/logic"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"strings"
	"text/template"
)

func homeHandleFunc(w http.ResponseWriter, req *http.Request) {
	tpl, err := template.ParseFiles("../template/home.html")	//解析主页模板并渲染
	if err != nil {
		fmt.Fprint(w, "模板解析错误！")
		return
	}

	err = tpl.Execute(w, nil)
	if err != nil {
		fmt.Fprint(w, "模板执行错误！")
		return
	}
}

func userListHandleFunc(w http.ResponseWriter, req *http.Request) {
	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	userList := logic.Broadcaster.GetUserList()		//获取当前在线用户列表
	b, err := json.Marshal(userList)				//将用户列表转换为JSON格式

	if err != nil {
		fmt.Fprint(w, `[]`)
	} else {
		fmt.Fprint(w, string(b))					//返回用户列表的JSON字符串
	}
}

func handleUpload(w http.ResponseWriter, request *http.Request) {
	var token string
	//文件上传只允许POST方法
	if request.Method != http.MethodPost {
		w.WriteHeader(http.StatusMethodNotAllowed)
		_, _ = w.Write([]byte("Method not allowed"))
		return
	}

	//从表单中读取文件
	file, fileHeader, err := request.FormFile("file")
	authorizationHeader := request.Header.Get("Authorization")
	if authorizationHeader != "" {
		// Split the header value by space
		parts := strings.Split(authorizationHeader, " ")
		if len(parts) == 2 && parts[0] == "Bearer" {
			token = parts[1]
			fmt.Println("token =" + token)
		} else {
			fmt.Println("Authorization header format must be: Bearer {token}")
		}
	} else {
		fmt.Println("No Authorization header provided")
	}
	fmt.Println("token =" + token)
	//使用token获取用户名称
	nickname, err := logic.ParseTokenAndValidate(token)
	fmt.Println(nickname)
	if err != nil {
		_, _ = io.WriteString(w, "Read file error")
		return
	}
	//defer 结束时关闭文件
	defer file.Close()
	// 根据用户昵称和原始文件名创建新的文件名，防止文件名冲突
	newFilename := nickname + "_" + fileHeader.Filename
	log.Println("filename: " + newFilename)

	//创建文件
	newFile, err := os.Create("../upload/" + newFilename)
	if err != nil {
		_, _ = io.WriteString(w, "Create file error")
		return
	}
	//defer 结束时关闭文件
	defer newFile.Close()

	//将文件写到本地
	_, err = io.Copy(newFile, file)
	if err != nil {
		_, _ = io.WriteString(w, "Write file error")
		return
	}
	// msg := logic.NewFileUploadMessage(username, fileHeader.Filename)
	// logic.Broadcaster.Broadcast(msg)
	msg := logic.NewFileUploadMessage(nickname, fileHeader.Filename)
	logic.Broadcaster.Broadcast(msg)

	_, _ = io.WriteString(w, "Upload success")

}

func handleDownload(w http.ResponseWriter, request *http.Request) {
	//文件下载只允许GET方法
	if request.Method != http.MethodGet {
		w.WriteHeader(http.StatusMethodNotAllowed)
		_, _ = w.Write([]byte("Method not allowed"))
		return
	}
	//文件名
	filename := request.FormValue("filename")
	if filename == "" {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = io.WriteString(w, "Bad request")
		return
	}
	// 检查filename是否包含"../"，防止路径遍历攻击
	if strings.Contains(filename, "../") {
		w.WriteHeader(http.StatusForbidden)
		_, _ = io.WriteString(w, "Illegal access")
		return
	}
	log.Println("filename: " + filename)
	//打开文件
	file, err := os.Open("../upload/" + filename)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = io.WriteString(w, "Bad request")
		return
	}
	//结束后关闭文件
	defer file.Close()

	//设置响应的header头
	w.Header().Add("Content-type", "application/octet-stream")
	w.Header().Add("content-disposition", "attachment; filename=\""+filename+"\"")
	//将文件写至responseBody
	_, err = io.Copy(w, file)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		_, _ = io.WriteString(w, "Bad request")
		return
	}
}

/*
安全性考虑
在handleUpload中，通过Authorization头进行简单的身份验证，并在上传文件前验证token。
在handleDownload中，检查文件名是否包含../，防止路径遍历攻击，从而访问服务器上的任意文件。
*/