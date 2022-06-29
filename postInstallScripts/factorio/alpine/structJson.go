package alpine

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	// "github.com/TylerBrock/colorjson"
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
var unstructData map[string]interface{}
var data Data

// figure out pointers * and address-of operator (&)

// TODO: pass a struct if possible
func ParseOrder(path string, debug bool) (Data, error) {
	// Open our jsonFile
	jsonFile, err := os.Open(path)
	// if we os.Open returns an error then handle it
	if err != nil {
		// return nil, fmt.Errorf("--- unable to import file %s ---", path)
		return data, fmt.Errorf("--- unable to import file %s ---", path)
	}
	defer jsonFile.Close()

	byteValue, _ := ioutil.ReadAll(jsonFile)

	json.Unmarshal([]byte(byteValue), &data)
	// color json options
	// f := colorjson.NewFormatter()
	// f.Indent = 2

	// s, _ := f.Marshal(data)
	// if debug {
	// 	fmt.Println(string(s))
	// 	fmt.Println(&data)
	// }
	return data, nil
}
