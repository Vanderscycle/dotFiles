package alpine

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"

	"github.com/TylerBrock/colorjson"
	"github.com/akamensky/argparse"
)

// structure (not used)
type Bash struct {
	Args []string `json:"args"`
	Cmd  string   `json:"cmd"`
}

type Data struct {
	Schema  []string `json:"schema"`
	Kubectl []Bash   `json:"kubectl"`
	Test    []Bash   `json:"test"`
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
	f := colorjson.NewFormatter()
	f.Indent = 2

	s, _ := f.Marshal(data)
	if debug {
		fmt.Println(string(s))
		fmt.Println(&data)
	}
	return data, nil
}

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

type availArgs struct {
	Path     string
	LogLevel string
}

//
func ArgParser() (availArgs, error) {
	// Create new parser object
	parser := argparse.NewParser("print", "Prints provided string to stdout")

	path := parser.String("p", "path", &argparse.Options{Required: true, Help: "Path of the json config file"})
	logLevel := parser.Selector("d", "debug-level", []string{"INFO", "DEBUG", "WARN"}, &argparse.Options{Required: false, Help: "Log level desire", Default: "INFO"})

	// Parse input
	err := parser.Parse(os.Args)
	if err != nil {
		fmt.Print(parser.Usage(err))
		return availArgs{*path, *logLevel}, fmt.Errorf("--- unable to parse args --- %s", err)
	}

	return availArgs{*path, *logLevel}, nil
}
