package utils

import (
	"encoding/json"
	// "fmt"
	"github.com/zcalusic/sysinfo"
	"log"
	// "os/user"
	"runtime"
)

func OsCheck() {
	if runtime.GOOS == "windows" {
		log.Print("Detected: %s; Program not implemented for windows machines", runtime.GOOS)
	} else {
		log.Print("Detected: %s", runtime.GOOS)
		checkLinuxVersion()
	}
}

func checkLinuxVersion() {

	var si sysinfo.SysInfo

	si.GetSysInfo()

	data, err := json.MarshalIndent(&si, "", "  ")
	if err != nil {
		log.Fatal(err)
	}

	log.Print(string(data))
}
