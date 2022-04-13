package main

import (
	"endavourOs/install"
	"log"
	"strings"
)

var PkgManagers = []string{"pacman", "yay"}
var EssentialPackages = []string{"neofetch", "sed"}
var ArgsInstall = []string{"-S", "--needed", "--noconfirm"}

func main() {
	// we could go function install several packages: e.g. cli,tui,gui,etc...
	//Installing tui
	command := append([]string{"sudo"}, PkgManagers[0]) // in this example it requires sudo
	command = append(command, ArgsInstall...)
	command = append(command, EssentialPackages...)
	log.Printf("[INFO]%s", strings.Join(command, " "))

	err := install.Bash(PkgManagers[0], command)
	if err != nil {
		log.Println("error format")
		panic(err)
	}
}
