package alpine

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"

	"github.com/TylerBrock/colorjson"
)

//unstructured
// https://tutorialedge.net/golang/parsing-json-with-golang/#working-with-unstructured-data
var data map[string]interface{}

// figure out pointers * and address-of operator (&)
func ParseOrder(path string) (map[string]interface{}, error) {
	// Open our jsonFile
	jsonFile, err := os.Open(path)
	// if we os.Open returns an error then handle it
	if err != nil {
		return nil, fmt.Errorf("--- unable to import file %s ---", path)
	}
	defer jsonFile.Close()

	byteValue, _ := ioutil.ReadAll(jsonFile)

	json.Unmarshal([]byte(byteValue), &data)
	// color json options
	f := colorjson.NewFormatter()
	f.Indent = 2

	s, _ := f.Marshal(data)
	fmt.Println(string(s))
	return data, nil
}
