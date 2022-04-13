package install

import (
	"errors"
	"fmt"
	// "log"
	"os"
	"os/exec"
	// "strings"
	"syscall"
)

//INFO: https://stackoverflow.com/questions/17555857/go-unpacking-array-as-arguments

func Bash(shellProgram string, pkgs []string) error {

	// pkgManagers := new(PkgManagers).Init()
	//WIP:testing for pacman only
	binary, lookErr := exec.LookPath(shellProgram)
	//TODO: need better catch as I get fatal errors
	if lookErr != nil {
		myError := errors.New(fmt.Sprintf("[404]%s not installed-> Error:%s", shellProgram, lookErr))
		return myError
	}

	env := os.Environ()

	//slices -> string (concatenation)
	// flags := strings.Join(EverPresentArgs, " ")
	// pkgStr := strings.Join(pkgs, " ")
	// args := fmt.Sprintf("sudo %s %s %s", shellProgram, flags, pkgStr)
	// log.Println(args)
	// //appending to string
	// v = append(v, EverPresentArgs...)

	//really confused with the sudo
	//INFO: you can call sudo like "/bin/sh"
	execErr := syscall.Exec(binary, pkgs, env)
	if execErr != nil {
		myError := errors.New(fmt.Sprintf("[COMMAND]%s Error:%s", pkgs, lookErr))

		return myError
	}
	return nil
}
