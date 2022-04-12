package main

import (
	"endavourOs/install"
	"log"
)

func main() {
	err := install.Installer([]string{"sedx"}...)
	if err != nil {
		log.Println("error format")
		panic(err)
	}
}
