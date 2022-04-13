package install

import (
	"errors"
	"fmt"
	"log"
	"os"
	"os/exec"
	"strings"
	"syscall"
)

//INFO: https://stackoverflow.com/questions/17555857/go-unpacking-array-as-arguments
var EssentialPackages = []string{"neofetch", "sed"}
var PkgManagers = []string{"pacman", "yay"}
var EverPresentArgs = []string{"-S", "--needed", "--noconfirm"}

func Bash(shellProgram string, pkgs ...string) error {

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
	flags := strings.Join(EverPresentArgs, " ")
	pkgStr := strings.Join(pkgs, " ")
	args := fmt.Sprintf("sudo %s %s %s", PkgManagers[0], flags, pkgStr)
	log.Println(args)
	//appending to string
	v := append([]string{"sudo"}, []string{PkgManagers[0]}...)
	v = append(v, EverPresentArgs...)
	v = append(v, pkgs...)
	log.Print(v)

	//really confused with the sudo
	//INFO: you can call sudo like "/bin/sh"
	execErr := syscall.Exec(binary, v, env)
	if execErr != nil {
		myError := errors.New(fmt.Sprintf("[COMMAND]%s Error:%s", v, lookErr))

		return myError
	}
	return nil
}
