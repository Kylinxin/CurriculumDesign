package server

import (
	"net/http"

	"chatroom_version1/logic"
)

// 注册不同的处理函数
func RegisterHandle() {
	// 广播消息处理
	go logic.Broadcaster.Start() //在一个新的goroutine中启动消息广播器

	http.HandleFunc("/", homeHandleFunc)  				//处理主页请求	
	http.HandleFunc("/user_list", userListHandleFunc)	//处理用户列表请求
	http.HandleFunc("/ws", WebSocketHandleFunc)			//处理websocket请求
	http.HandleFunc("/upload", handleUpload)			//处理上传文件请求
	http.HandleFunc("/download", handleDownload)		//处理下载文件请求
}
