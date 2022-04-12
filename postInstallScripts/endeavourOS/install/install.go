package install

import (
	"os"
	"os/exec"
	"syscall"
)

var EssentialPackages = [1]string{"vim"}

type PkgManagers struct {
	Pacman string
	Yay    string
}                                                 //[]string = []string{"pacman", "yay"}
func (p *PkgManagers) Init(pkgsMgr ...string) (PkgManagers, error) { t := PkgManagers{pkgsMgr...};return t, nil }

// func (p *PkgManagers) P() (string, error) { return p.Pacman, nil }
func Installer(pkgs ...string) {

	pkgManagers := new(PkgManagers).Init()
	everPresentArgs := []string{"-S", "--needed", "--noconfirm"}
	//WIP:testing for pacman only
	binary, lookErr := exec.LookPath(pkgManagers.Pacman)
	if lookErr != nil {
		panic(lookErr)
	}

	env := os.Environ()

	for _, pkg := range EssentialPackages {
		args := []string{PkgManager, "add", pkg}
		execErr := syscall.Exec(binary, args, env)
		if execErr != nil {
			panic(execErr)
		}

	}

}
