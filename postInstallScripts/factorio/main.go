package main

import (
	"factorio/server/alpine"
	"log"
	// "reflect" //check the type
)

var orderInstall = []string{"Kubectl", "Test"}

func main() {
	args, errParser := alpine.ArgParser()
	if errParser != nil {
		log.Fatal(errParser)
	}
	log.Print(args)

	var json, err = alpine.ParseOrder(args.Path, false)
	if err != nil {
		log.Fatal(err)
	}

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
