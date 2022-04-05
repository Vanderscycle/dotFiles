package utils

import (
	"encoding/json"
	"errors"
	"log"

	"runtime"

	"github.com/tidwall/gjson"
	"github.com/zcalusic/sysinfo"
)

func OsCheck(distro string) error {
	if runtime.GOOS == "windows" {
		log.Fatal("Detected: %v\n; Program not implemented for windows machines", runtime.GOOS)
		return errors.New("windows detected")
	} else {
		// log.Print doesn't format the string
		log.Printf("Detected: %v\n", runtime.GOOS)
		detectedDistro := checkLinuxVersion()

		if detectedDistro != distro {
			log.Fatalf("Expected %s but detected %s", distro, detectedDistro)
			return errors.New("wrong Linux distro detected")
		}
	}
	return nil
}

func checkLinuxVersion() string {

	var si sysinfo.SysInfo

	si.GetSysInfo()

	data, err := json.MarshalIndent(&si, "", "  ")
	if err != nil {
		log.Fatal(err)
	}
	value := gjson.GetBytes(data, "os.vendor").Str //because data is type []byte
	// log.Print(value)
	return value
}
