package main

import (
	"endavourOs/bash"
	"log"
	"os"
)

var PkgManagers = []string{"pacman", "yay"}
var EssentialPackages = []string{"neofetch", "sed"}
var ArgsInstall = []string{"-S", "--needed", "--noconfirm"}
var amazingTUI = []string{}

func main() {
	err := bash.General("ls", []string{"-l"}, nil, true)
	if err != nil {
		log.Fatal(err)
		os.Exit(2)
	}
}
