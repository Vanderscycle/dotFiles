package main

import (
	"factorio/server/alpine"
	"log"
	// "reflect" //check the type
)

var orderInstall = []string{"Kubectl", "Test"}

func main() {
	json, err := alpine.ParseOrder("routines/k8s.json", false)
	if err != nil {
		log.Fatal(err)
	}
	// log.Print(len(json.Test[0].Args))
	// json2, _ := alpine.UnstructuredParseOrder("routines/k8s.json" , false)
	// log.Println(json2)
	for _, block := range orderInstall {
		log.Print(block)
	}
	log.Print(json)
	for _, v := range json.Test {
		err = alpine.Apk(v.Cmd, v.Args)
		if err != nil {
			log.Fatal(err)
		}
	}
	// err = alpine.Apk(json.Test[1].Cmd, json.Test[1].Args)
	// if err != nil {
	// 	log.Fatal(err)
	// }

	log.Printf("%s started", "factorio k8")

}
