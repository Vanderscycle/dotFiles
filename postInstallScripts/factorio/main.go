package main

import (
	"factorio/server/alpine"
	"log"
	// "reflect" //check the type
)

func main() {
	json, err := alpine.ParseOrder("routines/k8s.json")
	if err != nil {
		log.Fatal(err)
	}
	log.Print(len(json.Test[0].Args))
	json2, _ := alpine.UnstructuredParseOrder("routines/k8s.json")
	log.Println(json2)
	// for k, v := range json {
	// https://stackoverflow.com/questions/41665383/accessing-data-from-interfaces-in-go
	// https://stackoverflow.com/questions/28806951/accessing-nested-map-of-type-mapstringinterface-in-golang
	// if v.([]interface{})[1] == "neofetch" {
	// log.Println(k, "value is", v.([]interface{})[0])
	// log.Printf("Hello, %s\n", v.([]interface{})[0])
	// }
	// }

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
