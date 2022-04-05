package utils

import (
	"log"
	"runtime"
)

func OsCheck() {
	if runtime.GOOS == "windows" {
		log.Print("Detected: %s; Program not implemented for windows machines", runtime.GOOS)
	} else {
		log.Print("Detected: %s", runtime.GOOS)
	}
}
