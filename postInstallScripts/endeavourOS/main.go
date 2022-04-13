package main

import (
	"endavourOs/bash"
	"log"
	"os"
)

type error struct{}

type pkg struct {
	Installer string
	Program   string
}

var PkgManagers = []string{"pacman", "yay"}
var ArgsInstall = []string{"-S", "--needed", "--noconfirm"}
var amazingTUI = []string{"curl wget"}
var lvimPkgs = []string{"neovim"}

//TODO: create a struct method to combine the pkgmanager with program in one line
var bareMetal = []string{"curl", "wget", "git", "base-devel", "clang"}
var languages = []string{"go", "clang", "node", "npm"}
var lintersFormatters = []string{"shellcheck-bin"}
var lintersFormattersYay = []string{"shellcheck-bin"}
var terminal = []Pkg{{Installer: PkgManagers[1], Program: "tmuxinator"}, {Installer: PkgManagers[0], Program: "kitty"}, {Installer: PkgManagers[0], Program: "zellij"}}

func main() {
	//syncing doots
	// URL: "https://github.com/Vanderscycle/dot-config.git ",

	// err := bash.Update(PkgManagers[1], true)
	// if err != nil {
	// 	log.Fatal(err)
	// 	os.Exit(2)
	// }
	var err = bash.Pacman(ArgsInstall, bareMetal, false)
	if err != nil {
		log.Fatal(err)
		os.Exit(2)
	}

	err = bash.Root("npm", []string{"i", "-g"}, []string{"prettier", "eslint", "neovim", "tree-sitter-cli"}, true)
	if err != nil {
		log.Fatal(err)
		os.Exit(2)
	}

	err = bash.General("ls", []string{"-l", "-a"}, nil, true)
	if err != nil {
		log.Fatal(err)
		os.Exit(2)
	}
}
