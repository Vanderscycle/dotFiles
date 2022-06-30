package alpine

import (
	"encoding/json"
	"factorio/server/utils"
	"fmt"
	"io/ioutil"
	"os"
)

// structure (not used)
type Bash struct {
	Args []string `json:"args"`
	Cmd  string   `json:"cmd"`
}

type Data struct {
	Schema []string `json:"schema"`
	Build  []Bash   `json:"build"`
	Test   []Bash   `json:"test"`
}

//unstructured
// https://tutorialedge.net/golang/parsing-json-with-golang/#working-with-unstructured-data
var data Data

// figure out pointers * and address-of operator (&)

// TODO: pass a struct if possible
func ParseOrder(path string) (Data, error) {
	s := NewStuff(*utils.NewBuiltinLogger("logs.log"))
	// Open our jsonFile
	jsonFile, err := os.Open(path)
	if err != nil {
		s.logger.Error("--- unable to import file %s ---", path)
		return data, fmt.Errorf("--- unable to import file %s ---", path)
	}
	defer jsonFile.Close()

	byteValue, _ := ioutil.ReadAll(jsonFile)
	json.Unmarshal([]byte(byteValue), &data)

	utils.PrettyPrintJSON([]byte(byteValue))

	return data, nil
}
