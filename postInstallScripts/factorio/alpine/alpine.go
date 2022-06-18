package alpine

import (
	"bytes"
	"fmt"
	"log"
	"os/exec"
	"strings"
)

const ShellToUse = "bash"

func Shellout(command string) (error, string, string) {
	var stdout bytes.Buffer
	var stderr bytes.Buffer
	cmd := exec.Command(ShellToUse, "-c", command)
	cmd.Stdout = &stdout
	cmd.Stderr = &stderr
	err := cmd.Run()
	return err, stdout.String(), stderr.String()
}

func Apk(cmd string, args []string) error {
	command := cmd + " " + strings.Join(args[:], " ")
	err, out, errout := Shellout(command)
	if err != nil {
		// log.Printf("error: %v\n", err)
		// log.Fatal(errout)
		return fmt.Errorf("%s", errout)
	}
	log.Println("--- stdout ---")
	log.Println(out)
	return nil
}
