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
	LogLevel      string
}

func NewBuiltinLogger(path string) *BuiltinLogger {

	file, err := os.OpenFile(path, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0666)
	if err != nil {
		log.Fatal(err)
	}
	return &BuiltinLogger{
		InfoLogger:    log.New(file, "INFO: ", log.Ldate|log.Ltime|log.Lshortfile),
		WarningLogger: log.New(file, "WARNING: ", log.Ldate|log.Ltime|log.Lshortfile),
		ErrorLogger:   log.New(file, "ERROR: ", log.Ldate|log.Ltime|log.Lshortfile),
		LogFilePath:   path,
		LogLevel:      os.Getenv("DEBUG_LVL"),
	}
}

func (l *BuiltinLogger) ClearLogFile() {
	logPresence, errFile := exists(l.LogFilePath)
	if errFile != nil {
		log.Fatal(errFile)
	}

	if logPresence == true {
		log.Printf("log file: %s detected! deleting", l.LogFilePath)
		os.Remove(l.LogFilePath)
	}
}

//INFO severity level
func (l *BuiltinLogger) Info(args ...interface{}) {
	if l.LogLevel != "NONE" {
		log.Println(args...)
	}
	l.InfoLogger.Println(args...)
}

//WARNING severity level
func (l *BuiltinLogger) Warn(args ...interface{}) {
	if l.LogLevel != "NONE" {
		log.Println(args...)
	}
	l.WarningLogger.Println(args...)
}

//ERROR severity level
func (l *BuiltinLogger) Error(args ...interface{}) {
	if l.LogLevel != "NONE" {
		log.Println(args...)
	}
	l.ErrorLogger.Println(args...)
}

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
