package alpine

import (
	"fmt"
	// "log"
	"strings"

	"factorio/server/utils"
)

type Stuff struct {
	logger utils.BuiltinLogger
}

func NewStuff(logger utils.BuiltinLogger) *Stuff {
	return &Stuff{logger: logger}
}

const ShellToUse = "bash"

// Only able to execute simple bash commands
func Apk(cmd string, args []string) error {
	command := cmd + " " + strings.Join(args[:], " ")
	err, out, errout := utils.Shellout(command, ShellToUse)
	if err != nil {
		return fmt.Errorf("--- stderr { %s } ---\n%s", command, errout)
	}
	s := NewStuff(*utils.NewBuiltinLogger("logs.log"))
	s.logger.Debug(fmt.Sprintf("--- stdout { %s } ---\n%s", command, out))
	return nil
}
