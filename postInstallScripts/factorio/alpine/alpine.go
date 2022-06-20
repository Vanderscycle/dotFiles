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

// Only able to execute simple bash commands
func Apk(cmd string, args []string) error {
	command := cmd + " " + strings.Join(args[:], " ")
	err, out, errout := Shellout(command)
	if err != nil {
		return fmt.Errorf("--- stderr { %s } ---\n%s", command, errout)
	}
	log.Println()
	log.Printf("--- stdout { %s } ---\n%s", command, out)
	return nil
}
