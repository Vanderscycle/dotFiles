package main

import (
	"endavourOs/bash"
	"log"
	"os"
)

var PkgManagers = []string{"pacman", "yay"}
var EssentialPackages = []string{"neofetch", "sed"}
var ArgsInstall = []string{"-S", "--needed", "--noconfirm"}
var amazingTUI = []string{""}
var lvimPkgs = []string{"neovim"}

func main() {
	//syncing doots
		URL: "https://github.com/Vanderscycle/dot-config.git ",


	err := bash.General("ls", []string{"-l", "-a"}, nil, true)
	if err != nil {
		log.Fatal(err)
		os.Exit(2)
	}
}
