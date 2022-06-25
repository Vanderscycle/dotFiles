package main

import (
	"factorio/server/alpine"
	"log"
	"reflect"
	// "reflect" //check the type
)

func main() {
	args, errParser := alpine.ArgParser()
	if errParser != nil {
		log.Fatal(errParser)
	}

	var json, err = alpine.ParseOrder(args.Path, false)
	if err != nil {
		log.Fatal(err)
	}

	// generics...ish
	// figure a way to enfore order e.g. installer, build, deployment, etc...
	// https://stackoverflow.com/questions/18926303/iterate-through-the-fields-of-a-struct-in-go
	v := reflect.ValueOf(json)
	for i := 0; i < v.NumField(); i++ {

		switch v.Type().Field(i).Name {

		case json.Schema[1]:
			log.Print(json.Schema[1])

		default:
			log.Println(v.Type().Field(i).Name)
			log.Println("\t", v.Field(i))
		}
	}
	// log.Print(json)
	for _, v := range json.Test {
		err = alpine.Apk(v.Cmd, v.Args)
		if err != nil {
			log.Fatal(err)
		}
	}
	log.Printf("%s started", "factorio k8")
}
