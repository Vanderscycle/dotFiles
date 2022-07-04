package alpine

import (
	"fmt"
	// "log"
	"strings"

	"factorio/server/utils"
)

//INFO: shared accross packages
type Stuff struct {
	logger utils.BuiltinLogger
}

func NewStuff(logger utils.BuiltinLogger) *Stuff {
	return &Stuff{logger: logger}
}

const ShellToUse = "bash"

// Only able to execute simple bash commands
func Apk(cmd string, args []string) error {
	s := NewStuff(*utils.NewBuiltinLogger("logs.log"))
	command := cmd + " " + strings.Join(args[:], " ")
	err, out, errout := utils.Shellout(command, ShellToUse)
	if err != nil {
		s.logger.Error("--- stderr { %s } ---\n%s", command, errout)
		return fmt.Errorf("--- stderr { %s } ---\n%s", command, errout)
	}
	s.logger.Info(fmt.Sprintf("--- stdout { %s } ---\n%s", command, out))
	return nil
}
