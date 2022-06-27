package utils

import (
	"fmt"
	"log"
	"runtime"
)

func Installer() error {
	log.Println(runtime.GOOS, runtime.GOARCH)
	if runtime.GOOS == "linux" {
		log.Println("Hello from Linux")
		return nil
	} else {
		err := fmt.Errorf("%s", "not on linux")
		return err
	}
}
