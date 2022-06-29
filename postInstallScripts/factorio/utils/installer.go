package utils

import (
	"encoding/json"
	"fmt"
	"log"

	"runtime"

	"github.com/tidwall/gjson"
	"github.com/zcalusic/sysinfo"
)

func OsCheck(distro string) error {
	if runtime.GOOS != "linux" {
		err := fmt.Errorf("Detected: %v\n; Program not implemented for windows machines", runtime.GOOS)
		return err

	} else {
		// log.Print doesn't format the string
		detectedDistro := checkLinuxVersion()

		if detectedDistro != distro {
			err := fmt.Errorf("Expected %s but detected %s", distro, detectedDistro)
			return err
		}
	}
	return nil
}

func checkLinuxVersion() string {

	var si sysinfo.SysInfo

	si.GetSysInfo()
	PrettyPrintJSON(&si, true)
	log.Print(&si)
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
