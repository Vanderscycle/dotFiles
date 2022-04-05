package main

import (
	"alpine/utils"
	"log"
)

func main() {
	distro := "endeavouros"
	e := utils.OsCheck(distro)
	if e != nil {
		log.Fatalf("Expected %s but detected other distro", distro)
	}
}
