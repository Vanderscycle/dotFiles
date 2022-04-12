package install

import (
	"fmt"
	"log"
	// "os"
	"os/exec"
	"strings"
	// "syscall"
)

//INFO: https://stackoverflow.com/questions/17555857/go-unpacking-array-as-arguments
var EssentialPackages = []string{"neofetch", "sed"}
var PkgManagers = [2]string{"pacman", "yay"}
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
	_, lookErr := exec.LookPath(pkgs[0])
	if lookErr != nil {
		panic(lookErr)
	}

	// env := os.Environ()

	//slices -> string (concatenation)
	flags := strings.Join(EverPresentArgs, " ")
	pkgStr := strings.Join(pkgs, " ")
	args := fmt.Sprintf("%s %s %s", pkgs[0], flags, pkgStr)
	log.Println(args)

	v := append([]string{PkgManagers[0]}, EverPresentArgs...)
	v = append(v, pkgs...)
	log.Print(v)

	// execErr := syscall.Exec(binary, "", env)
	// if execErr != nil {
	// 	panic(execErr)
	// }

}
