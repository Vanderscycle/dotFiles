package install

import (
	"os"
	"os/exec"
	"syscall"
)

//INFO: https://stackoverflow.com/questions/17555857/go-unpacking-array-as-arguments
var EssentialPackages = [1]string{"vim"}
var PkgManagers = [2]string{"pacman", "yay"}
var EverPresentArgs = [3]string{"-S", "--needed", "--noconfirm"}

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

	for _, pkg := range pkgs {
		args := []string{PkgManagers[0], "add", pkg}
		execErr := syscall.Exec(binary, args, env)
		if execErr != nil {
			panic(execErr)
		}

	}

}
