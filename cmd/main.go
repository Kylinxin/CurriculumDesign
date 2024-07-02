package main

import (
	"chatroom_version1/server"
	"log"
	"net/http"
)

func main() {
	addr := ":8080"

	server.RegisterHandle() //注册处理客户端请求的函数

	log.Fatal(http.ListenAndServe(addr, nil)) //启动http服务器
}
