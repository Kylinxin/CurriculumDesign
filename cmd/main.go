package main

import (
	"chatroom_version1/server"
	"log"
	"net/http"
)

func main() {
	addr := ":8080"

	server.RegisterHandle()

	log.Fatal(http.ListenAndServe(addr, nil))
}
