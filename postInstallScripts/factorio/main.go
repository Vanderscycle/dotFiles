package main

import (
	"factorio/server/alpine"
	"factorio/server/utils"
	"log"
	"reflect"
	// "reflect" //check the type
)

//TODO: rename this correctly
type Stuff struct {
	logger utils.BuiltinLogger
}

func NewStuff(logger utils.BuiltinLogger) *Stuff {
	return &Stuff{logger: logger}
}

//init the logger
var s = NewStuff(*utils.NewBuiltinLogger("logs.log"))

func main() {

	// handle file args
	args, errParser := utils.ArgParser()
	if errParser != nil {
		log.Fatal(errParser)
	}

	s.logger.ClearLogFile()

	unStructuredJSON(args)

	//TODO: figure out the json bag of strings

}

//
func unStructuredJSON(args utils.AvailArgs) {
	var json, err = alpine.UnstructuredParseOrder(args.Path)
	if err != nil {
		log.Fatal(err)
	}
	s.logger.Info(json["test"])
	var test = json["schema"]
	for _, val := range test {
		s.logger.Info(val)
		s.logger.Info(reflect.TypeOf(val))
		//https://www.sohamkamani.com/golang/type-assertions-vs-type-conversions/
		s.logger.Info(json[val.(string)])      //
		s.logger.Info(len(json[val.(string)])) //
		s.logger.Info(json[val.(string)][0])   //

	}
}

func structuredJSON(args utils.AvailArgs) {
	// generics...ish
	// figure a way to enfore order e.g. installer, build, deployment, etc...
	// https://stackoverflow.com/questions/18926303/iterate-through-the-fields-of-a-struct-in-go
	var json, err = alpine.ParseOrder(args.Path)
	if err != nil {
		log.Fatal(err)
	}
	rv := reflect.ValueOf(json)
	for i := 0; i < rv.NumField(); i++ {

		switch rv.Type().Field(i).Name {

		case json.Schema[1]:
			log.Print(json.Schema[1])
			vSchema := rv.FieldByName("Test")

			log.Print(vSchema.Kind())
			// log.Print(json)

		default:
			log.Println(rv.Type().Field(i).Name)
			log.Println("\t", rv.Field(i))
			log.Println(reflect.TypeOf(rv.Field(i)))
		}
	}
	// log.Print(json)
	for _, v := range json.Build {
		err = alpine.Apk(v.Cmd, v.Args)
		if err != nil {
			log.Fatal(err)
		}
	}
	for _, v := range json.Test {
		err = alpine.Apk(v.Cmd, v.Args)
		if err != nil {
			log.Fatal(err)
		}
	}
}
