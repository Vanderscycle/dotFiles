package utils

import (
	"encoding/json"
	"fmt"
	"log"

	"runtime"

	"github.com/TylerBrock/colorjson"
	"github.com/tidwall/gjson"
	"github.com/zcalusic/sysinfo"
)

// distro := "endeavouros"
// e := utils.OsCheck(distro)
// if e != nil {
// 	log.Fatal(e)
// }
type Stuff struct {
	logger BuiltinLogger
}

func NewStuff(logger BuiltinLogger) *Stuff {
	return &Stuff{logger: logger}
}

// checks for the distro used by the system
func OsCheck(distro string) error {
	if runtime.GOOS != "linux" {
		err := fmt.Errorf("Detected: %v\n; Program not implemented for windows machines", runtime.GOOS)
		return err
	} else {
		detectedDistro := checkLinuxVersion()

		if detectedDistro != distro {
			err := fmt.Errorf("Expected %s but detected %s", distro, detectedDistro)
			return err
		}
	}
	return nil
}

//checks for what linux distro is running
func checkLinuxVersion() string {

	var si sysinfo.SysInfo
	si.GetSysInfo()
	data, err := json.MarshalIndent(&si, "", "  ") //https://en.wikipedia.org/wiki/Marshalling_(computer_science)
	if err != nil {
		log.Fatal(err)
	}
	value := gjson.GetBytes(data, "os.vendor").Str //because data is type []byte
	return value
}

// using colorjson pretty print a json
func PrettyPrintJSON(rawStr []byte) {

	var obj map[string]interface{}
	json.Unmarshal(rawStr, &obj)

	// Make a custom formatter with indent set
	f := colorjson.NewFormatter()
	f.Indent = 2

	// Marshall the Colorized JSON
	// s, _ := f.Marshal(obj)
	// Logger(string(s))
	// log.Println(string(s))
}
