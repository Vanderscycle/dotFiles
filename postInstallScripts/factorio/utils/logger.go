package utils

import (
	"log"
	"os"
)

type BuiltinLogger struct {
	WarningLogger *log.Logger
	InfoLogger    *log.Logger
	ErrorLogger   *log.Logger
	LogFilePath   string
}

func NewBuiltinLogger(path string) *BuiltinLogger {
	// logPresence, errFile := exists(path)
	// if errFile != nil {
	// 	log.Fatal(errFile)
	// }

	// if logPresence == true {
	// 	log.Printf("log file: %s detected! deleting", path)
	// 	os.Remove(path)
	// }
	// //creates the log file
	file, err := os.OpenFile(path, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0666)
	if err != nil {
		log.Fatal(err)
	}
	return &BuiltinLogger{
		InfoLogger:    log.New(file, "INFO: ", log.Ldate|log.Ltime|log.Lshortfile),
		WarningLogger: log.New(file, "WARNING: ", log.Ldate|log.Ltime|log.Lshortfile),
		ErrorLogger:   log.New(file, "ERROR: ", log.Ldate|log.Ltime|log.Lshortfile),
		LogFilePath:   path,
	}
}

func (l *BuiltinLogger) Debug(args ...interface{}) {
	l.InfoLogger.Println(args...)
}

// func (l *BuiltinLogger) Debugf(format string, args ...interface{}) {
// 	l.logger.Printf(format, args...)
// }

// exists returns whether the given file or directory exists
func exists(path string) (bool, error) {
	_, err := os.Stat(path)
	if err == nil {
		return true, nil
	}
	if os.IsNotExist(err) {
		return false, nil
	}
	//other error
	return false, err
}
