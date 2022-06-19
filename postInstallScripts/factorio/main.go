package main

import (
	"factorio/server/alpine"
	"log"
	"reflect"
)

type Bash struct {
	Args []string `json:"args"`
	Cmd  string   `json:"cmd"`
}

type Data struct {
	Test    []Bash `json:"test"`
	Kubectl []Bash `json:"kubectl"`
}

func main() {
	json, err := alpine.ParseOrder("routines/k8s.json")
	if err != nil {
		log.Fatal(err)
	}
	log.Println(reflect.TypeOf(json))
	test := json["test"]
	log.Println(test)

	for _, name := range json {
		log.Printf("Hello, %s\n", name.([]string))
	}

	args := []string{"-la", "-z"}
	err = alpine.Apk("ls", args)
	if err != nil {
		log.Fatal(err)
	}
	// err = alpine.Apk()
	// if err != nil {
	// 	log.Printf("error: %v\n", err)
	// }
	log.Printf("%s started", "factorio k8")

}
