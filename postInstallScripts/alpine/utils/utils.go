package utils

import (
	"encoding/json"
	"log"

	"github.com/tidwall/gjson"
	"github.com/zcalusic/sysinfo"
	"runtime"
)

func OsCheck() {
	if runtime.GOOS == "windows" {
		log.Printf("Detected: %v\n; Program not implemented for windows machines", runtime.GOOS)
	} else {
		log.Printf("Detected: %v\n", runtime.GOOS) // log.Print doesn't format the string
		checkLinuxVersion()
	}
}

func checkLinuxVersion() string {

	var si sysinfo.SysInfo

	si.GetSysInfo()

	data, err := json.MarshalIndent(&si, "", "  ")
	if err != nil {
		log.Fatal(err)
	}
	value := gjson.GetBytes(data, "os.vendor").Str //because data is type []byte

	log.Print(value)
	return value
}
