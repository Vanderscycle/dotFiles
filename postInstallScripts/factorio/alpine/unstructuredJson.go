package alpine

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"

	"github.com/TylerBrock/colorjson"
)

// TODO: correctly parse unstructured data
func UnstructuredParseOrder(path string, debug bool) (map[string]interface{}, error) {
	// log.Print(len(json.Test[0].Args))
	// json2, _ := alpine.UnstructuredParseOrder("routines/k8s.json" , false)
	// log.Println(json2)
	var data map[string]interface{}
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
	if debug {
		fmt.Println(string(s))
		fmt.Println(&data)
	}
	return data, nil
}
