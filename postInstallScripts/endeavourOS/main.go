package main

import (
	"endavourOs/install"
	"log"
)

func main() {
	// we could go function install several packages: e.g. cli,tui,gui,etc...
	err := install.Bash(install.PkgManagers[0], []string{"sed"}...)
	if err != nil {
		log.Println("error format")
		panic(err)
	}
}
