package bash

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"strings"

	"syscall"
)

//INFO: https://stackoverflow.com/questions/17555857/go-unpacking-array-as-arguments

//check for the binaries of the program and execute them in shell
func Bash(shellProgram string, pkgs []string) error {

	binary, lookErr := exec.LookPath(shellProgram)
	//TODO: need better catch as I get fatal errors
	if lookErr != nil {
		myError := fmt.Errorf("[404]%s not installed-> Error:%s", shellProgram, lookErr)
		return myError
	}

	env := os.Environ()
	//INFO: you can call sudo like "/bin/sh"
	execErr := syscall.Exec(binary, pkgs, env)
	if execErr != nil {
		myError := fmt.Errorf("[COMMAND]%s Error:%s", pkgs, lookErr)
		return myError
	}
	return nil
}

//flags being associated with the prg e.g."yay" -S/-R as []string{}
//cmds should be related to the install prog as []string{}
func Pacman(flags []string, cmds []string, debug bool) error {
	s := append([]string{"sudo", "pacman"}, flags...)
	s = append(s, cmds...)
	if debug {
		//slices -> string (concatenation)
		log.Printf("[INFO] => %s", strings.Join(s, " "))
	}
	err := Bash("pacman", s)
	if err != nil {
		return fmt.Errorf("[ERR] => pacman failed: %s", s)
	}
	return nil
}

//flags being associated with the prg e.g."yay" -S/-R as []string{}
//cmds should be related to the install prog as []string{}
func Yay(flags []string, cmds []string, debug bool) error {
	s := append([]string{"sudo", "yay"}, flags...)
	s = append(s, cmds...)
	if debug {
		log.Printf("[INFO] => %s", strings.Join(s, " "))
	}
	err := Bash("yay", s)
	if err != nil {
		err := fmt.Errorf("[ERR] => yay failed: %s", s)
		return err
	}
	return nil
}

//flags being associated with the prg/"yay" .e.g -S/-R
//Cmds should be related to the install prog
//in general we sometimes do not need both flags and cmds so
//e.g. General("ls", []string{"-l", "-a"}, nil, true)
func General(prg string, flags []string, cmds []string, debug bool) error {
	s := append([]string{prg}, flags...)
	s = append(s, cmds...)
	if debug {
		log.Printf("[INFO] => %s", strings.Join(s, " "))
	}
	err := Bash(prg, s)
	if err != nil {
		err := fmt.Errorf("[ERR] => yay failed: %s", s)
		return err
	}
	return nil

}

//flags being associated with the prg/"yay" .e.g -S/-R
//Cmds should be related to the install prog
//in general we sometimes do not need both flags and cmds so
//e.g. Root("ls", []string{"-l", "-a"}, nil, true)
func Root(prg string, flags []string, cmds []string, debug bool) error {
	s := append([]string{"sudo", prg}, flags...)
	s = append(s, cmds...)
	if debug {
		log.Printf("[INFO] => %s", strings.Join(s, " "))
	}
	err := Bash(prg, s)
	if err != nil {
		err := fmt.Errorf("[ERR] => yay failed: %s", s)
		return err
	}
	return nil

}
