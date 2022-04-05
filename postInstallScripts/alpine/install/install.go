package install

import (
	"os"
	"os/exec"
	"syscall"
)

func Installer() {
	essentialPackages := []string{"vim", "sudo", "fish"}
	// var essentialPackages []string = []string{"vim", "sudo", "fish"}
	const pkgManager string = "apk"
	binary, lookErr := exec.LookPath(pkgManager)
	if lookErr != nil {
		panic(lookErr)
	}

	env := os.Environ()

	for _, pkg := range essentialPackages {
		args := []string{pkgManager, "add", pkg}
		execErr := syscall.Exec(binary, args, env)
		if execErr != nil {
			panic(execErr)
		}

	}

	lsExample()
}

func lsExample() {
	binary, lookErr := exec.LookPath("ls")
	if lookErr != nil {
		panic(lookErr)
	}

	args := []string{"ls", "-a", "-l", "-h"}

	env := os.Environ()

	execErr := syscall.Exec(binary, args, env)
	if execErr != nil {
		panic(execErr)
	}
}
