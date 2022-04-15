package main

import (
	"endavourOs/bash"
	"fmt"
	"io/ioutil"
	"log"

	"github.com/tidwall/gjson"
)

type Error struct{}

type Pkg struct {
	Installer string `json:"installer"`
	Program   string `json:"program"`
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

// var terminal = []pkg{{Installer: PkgManagers[1], Program: "tmuxinator"}, {Installer: PkgManagers[0], Program: "kitty"}, {Installer: PkgManagers[0], Program: "zellij"}}

func main() {

	//syncing doots
	// URL: "https://github.com/Vanderscycle/dot-config.git ",

	// err := bash.Update(PkgManagers[1], true)
	// if err != nil {
	// 	log.Fatal(err)
	// 	os.Exit(2)
	// }
	_ = LoadJson()

	err := bash.Pacman(ArgsInstall, bareMetal, false)
	if err != nil {
		log.Fatal(err)
	}

	err = bash.Root("npm", []string{"i", "-g"}, []string{"prettier", "eslint", "neovim", "tree-sitter-cli"}, true)
	if err != nil {
		log.Fatal(err)
	}

	err = bash.General("ls", []string{"-l", "-a"}, nil, true)
	if err != nil {
		log.Fatal(err)
	}
}

func LoadJson() error {
	// var terminal []Pkg
	p := "programs.json"
	file, err := ioutil.ReadFile(p)
	if err != nil {
		return fmt.Errorf("[404] => missing %s failed %s", p, err)
	}
	//gjson go is amazing https://github.com/tidwall/gjson
	value := gjson.Get(string([]byte(file)), "terminal")
	log.Print(value)
	return nil
}
