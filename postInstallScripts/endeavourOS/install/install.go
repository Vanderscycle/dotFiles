package install

import (
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

// type PkgManagers struct {
// 	Pacman string
// 	Yay    string
// }                                                 //[]string = []string{"pacman", "yay"}
// func (p *PkgManagers) Init(pkgsMgr ...string) (PkgManagers, error) { t := PkgManagers{pkgsMgr...};return t, nil }

// func (p *PkgManagers) P() (string, error) { return p.Pacman, nil }
func Installer(pkgs ...string) {

	// pkgManagers := new(PkgManagers).Init()
	//WIP:testing for pacman only
	binary, lookErr := exec.LookPath(PkgManagers[0])
	if lookErr != nil {
		panic(lookErr)
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
		panic(execErr)
	}

}
