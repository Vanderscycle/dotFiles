package main

import (
	"factorio/server/alpine"
	"log"
)

func main() {
	err := alpine.Apk()
	if err != nil {
		log.Printf("error: %v\n", err)
	}
	err = alpine.Apk()
	if err != nil {
		log.Printf("error: %v\n", err)
	}
	log.Printf("%s started", "factorio k8")

}
