package utils

import (
	"bytes"
	"fmt"
	"os/exec"

	"github.com/TylerBrock/colorjson"
)

func Shellout(command string, ShellToUse string) (error, string, string) {
	var stdout bytes.Buffer
	var stderr bytes.Buffer
	cmd := exec.Command(ShellToUse, "-c", command)
	cmd.Stdout = &stdout
	cmd.Stderr = &stderr
	err := cmd.Run()
	return err, stdout.String(), stderr.String()
}

func PrettyPrintJSON(data interface{}, debug bool) error {
	f := colorjson.NewFormatter()
	f.Indent = 2

	s, _ := f.Marshal(data)
	if debug {
		fmt.Println(string(s))
		fmt.Println(&data)
	}
	return nil
}
