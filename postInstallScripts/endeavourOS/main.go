package main

import (
	"endavourOs/install"
	"log"
	"strings"
)

var PkgManagers = []string{"pacman", "yay"}
var EssentialPackages = []string{"neofetch", "sed"}
var ArgsInstall = []string{"-S", "--needed", "--noconfirm"}
var amazingTUI = []string{}

func main() {
	// we could go function install several packages: e.g. cli,tui,gui,etc...
	//Installing tui
	// command := append([]string{"sudo"}, PkgManagers[0]) // in this example it requires sudo
	// command = append(command, ArgsInstall...)
	// command = append(command, EssentialPackages...)
	// log.Printf("[INFO]%s", strings.Join(command, " "))
	command := sudo(PkgManagers[0], ArgsInstall, EssentialPackages, false)

	err := install.Bash(PkgManagers[0], command)
	if err != nil {
		log.Println("error format")
		panic(err)
	}
}

func sudo(prg string, flags []string, cmds []string, debug bool) []string {
	s := append([]string{"sudo"}, []string{prg}...)
	s = append(s, flags...)
	s = append(s, cmds...)
	if debug {
		log.Printf("[INFO]%s", strings.Join(s, " "))

	}
	return s
}
