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
		log.Fatalf("Detected: %v\n; Program not implemented for windows machines", runtime.GOOS)
		return errors.New("windows detected")

	} else {
		// log.Print doesn't format the string
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
	//func Marshal(v interface{}) ([]byte, error)
	//tldr: like serialization
	data, err := json.MarshalIndent(&si, "", "  ") //https://en.wikipedia.org/wiki/Marshalling_(computer_science)
	if err != nil {
		log.Fatal(err)
	}
	value := gjson.GetBytes(data, "os.vendor").Str //because data is type []byte
	// log.Print(value)
	return value
}
