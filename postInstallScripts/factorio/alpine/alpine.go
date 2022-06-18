package alpine

import (
	"bytes"
	"log"
	"os/exec"
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

func Apk() {
	err, out, errout := Shellout("ls ltr")

	if err != nil {
		log.Printf("error: %v\n", err)
		log.Println(errout)
		return
	}
	log.Println("--- stdout ---")
	log.Println(out)
}
