package main

import (
	"endavourOs/install"
	"errors"
	"fmt"
	"log"
	"os"
	"strings"
)

var PkgManagers = []string{"pacman", "yay"}
var EssentialPackages = []string{"neofetch", "sed"}
var ArgsInstall = []string{"-S", "--needed", "--noconfirm"}
var amazingTUI = []string{}

func main() {
	err := General("ls", []string{"-l"}, nil, true)
	if err != nil {
		log.Fatal(err)
		os.Exit(2)
	}
}

func Pacman(flags []string, cmds []string, debug bool) error {
	//flags being associated with the prg/"yay" .e.g -S/-R
	//Cmds should be related to the install prog
	s := append([]string{"sudo", "pacman"}, flags...)
	s = append(s, cmds...)
	if debug {
		log.Printf("[INFO] => %s", strings.Join(s, " "))
	}
	err := install.Bash("pacman", s)
	if err != nil {
		return errors.New(fmt.Sprintf("[ERR] => pacman failed: %s", s))
	}
	return nil
}

func Yay(flags []string, cmds []string, debug bool) error {
	//flags being associated with the prg/"yay" .e.g -S/-R
	//Cmds should be related to the install prog
	s := append([]string{"sudo", "yay"}, flags...)
	s = append(s, cmds...)
	if debug {
		log.Printf("[INFO] => %s", strings.Join(s, " "))
	}
	err := install.Bash("yay", s)
	if err != nil {
		err := errors.New(fmt.Sprintf("[ERR] => yay failed: %s", s))
		return err
		// log.Fatalf("[ERR] => %s", err)
	}
	return nil
}

func General(prg string, flags []string, cmds []string, debug bool) error {
	//in general we sometimes do not need both flags and cmds so
	s := append([]string{prg}, flags...)
	s = append(s, cmds...)
	if debug {
		log.Printf("[INFO] => %s", strings.Join(s, " "))
	}
	err := install.Bash(prg, s)
	if err != nil {
		err := fmt.Errorf("[ERR] => yay failed: %s", s)
		return err
		// log.Fatalf("[ERR] => %s", err)
	}
	return nil

}

func Root(prg string, flags []string, cmds []string, debug bool) error {
	//in general we sometimes do not need both flags and cmds so
	s := append([]string{"sudo", prg}, flags...)
	s = append(s, cmds...)
	if debug {
		log.Printf("[INFO] => %s", strings.Join(s, " "))
	}
	err := install.Bash(prg, s)
	if err != nil {
		err := fmt.Errorf("[ERR] => yay failed: %s", s)
		return err
	}
	return nil

}
