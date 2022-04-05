package main

import (
	"alpine/utils"
	// "log"
)

func main() {
	distro := "endeavouross"
	e := utils.OsCheck(distro)
	if e != nil {
		panic("error detected")
	}
}
