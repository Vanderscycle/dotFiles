package alpine

import (
	"encoding/json"
	"factorio/server/utils"
	"fmt"
	"io/ioutil"
	"os"
)

// TODO: correctly parse unstructured data
var unstructData map[string][]interface{}

//func that parses json data in an unstructured order
func UnstructuredParseOrder(path string) (map[string][]interface{}, error) {

	var data map[string][]interface{}
	// Open our jsonFile
	jsonFile, err := os.Open(path)
	if err != nil {
		return nil, fmt.Errorf("--- unable to import file %s ---", path)
	}
	defer jsonFile.Close()

	byteValue, _ := ioutil.ReadAll(jsonFile)

	json.Unmarshal([]byte(byteValue), &data)

	if os.Getenv("DEBUG_LVL") != "NONE" {
		utils.PrettyPrintJSON([]byte(byteValue))
	}
	return data, nil
}
