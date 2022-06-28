package utils

import (
	"fmt"
	"log"
	"runtime"
)

func Installer() error {
	// if the cmd failed check if installed. if yes crash else ask to install it
	log.Println(runtime.GOOS, runtime.GOARCH)
	if runtime.GOOS == "linux" {
		log.Println("Hello from Linux")
		return nil
	} else {
		err := fmt.Errorf("%s", "not on linux")
		return err
	}
}
