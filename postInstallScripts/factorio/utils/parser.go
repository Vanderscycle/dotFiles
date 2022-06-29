package utils

import (
	"fmt"
	// "log"
	"os"

	"github.com/akamensky/argparse"
)

type AvailArgs struct {
	Path     string
	LogLevel string
}

// similar to python argParse
func ArgParser() (AvailArgs, error) {
	// Create new parser object
	parser := argparse.NewParser("print", "Program parsing a json file and executing its unix cmds")

	path := parser.String("p", "path", &argparse.Options{Required: true, Help: "Path of the json config file"})
	logLevel := parser.Selector("d", "debug-level", []string{"NONE", "INFO", "DEBUG", "WARN"}, &argparse.Options{Required: false, Help: "Log level desire", Default: "INFO"})

	// Parse input
	err := parser.Parse(os.Args)
	if err != nil {
		fmt.Print(parser.Usage(err))
		return AvailArgs{*path, *logLevel}, fmt.Errorf("--- unable to parse args --- %s", err)
	}

	os.Setenv("DEBUG_LVL", *logLevel)

	return AvailArgs{*path, *logLevel}, nil
}
