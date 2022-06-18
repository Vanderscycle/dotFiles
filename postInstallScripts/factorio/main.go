package main

import (
	"factorio/server/alpine"
	"log"
)

func main() {
	alpine.Apk()
	alpine.Apk()

	log.Printf("%s started", "factorio k8")

}
