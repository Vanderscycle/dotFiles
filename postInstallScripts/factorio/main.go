package main

import (
	"factorio/server/alpine"
	"fmt"
	"log"
	"os"
)

func parseOrder() { // Open our jsonFile
	jsonFile, err := os.Open("routines/k8s.json")
	// if we os.Open returns an error then handle it
	if err != nil {
		fmt.Println(err)
	}
	fmt.Println(jsonFile)
}
func main() {
	parseOrder()
	args := []string{"-la", "-z"}
	err := alpine.Apk("ls", args)
	if err != nil {
		log.Fatal(err)
	}
	// err = alpine.Apk()
	// if err != nil {
	// 	log.Printf("error: %v\n", err)
	// }
	log.Printf("%s started", "factorio k8")

}
