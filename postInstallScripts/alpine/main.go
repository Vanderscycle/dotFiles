package main

import (
	"alpine/install"
	"alpine/utils"
	// "log"
)

func main() {
	distro := "alpine"
	e := utils.OsCheck(distro)
	if e != nil {
		panic("error detected")
	}
	install.Installer()

}
