package alpine

import (
	"fmt"
	"log"
	"strings"

	"factorio/server/utils"
)

const ShellToUse = "bash"

// Only able to execute simple bash commands
func Apk(cmd string, args []string) error {
	command := cmd + " " + strings.Join(args[:], " ")
	err, out, errout := utils.Shellout(command, ShellToUse)
	if err != nil {
		return fmt.Errorf("--- stderr { %s } ---\n%s", command, errout)
	}
	log.Printf("--- stdout { %s } ---\n%s", command, out)
	return nil
}
