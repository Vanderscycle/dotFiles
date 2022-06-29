package utils

import (
	"log"
	"os"
)

var (
	WarningLogger *log.Logger
	InfoLogger    *log.Logger
	ErrorLogger   *log.Logger
)

func Init(path string) {

	logPresence, errFile := exists(path)
	if errFile != nil {
		log.Fatal(errFile)
	}

	if logPresence == true {
		log.Printf("log file: %s detected! deleting", path)
		os.Remove(path)
	}
	//creates the log file
	file, err := os.OpenFile(path, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0666)
	if err != nil {
		log.Fatal(err)
	}

	InfoLogger = log.New(file, "INFO: ", log.Ldate|log.Ltime|log.Lshortfile)
	WarningLogger = log.New(file, "WARNING: ", log.Ldate|log.Ltime|log.Lshortfile)
	ErrorLogger = log.New(file, "ERROR: ", log.Ldate|log.Ltime|log.Lshortfile)
}

func Logger(msg string) {
	log.Print(msg)
	InfoLogger.Println(msg)
	// InfoLogger.Println("Something noteworthy happened")
	// WarningLogger.Println("There is something you should know about")
	// ErrorLogger.Println("Something went wrong")
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
