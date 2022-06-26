package utils

import (
	"fmt"
	"os"

	"github.com/akamensky/argparse"
)

type AvailArgs struct {
	Path     string
	LogLevel string
}

func ArgParser() (AvailArgs, error) {
	// Create new parser object
	parser := argparse.NewParser("print", "Program parsing a json file and executing its unix cmds")

	path := parser.String("p", "path", &argparse.Options{Required: true, Help: "Path of the json config file"})
	logLevel := parser.Selector("d", "debug-level", []string{"INFO", "DEBUG", "WARN"}, &argparse.Options{Required: false, Help: "Log level desire", Default: "INFO"})

	// Parse input
	err := parser.Parse(os.Args)
	if err != nil {
		fmt.Print(parser.Usage(err))
		return AvailArgs{*path, *logLevel}, fmt.Errorf("--- unable to parse args --- %s", err)
	}

	return AvailArgs{*path, *logLevel}, nil
}
