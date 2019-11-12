package main

import (
	s "github.com/winwisely99/bootstrap/tool/googlesheet/services"
	"os"
	"log"
	
	"path/filepath"
)

func main() {

	// show line numbers
	log.SetFlags(log.LstdFlags | log.Lshortfile)
	
	log.Println("Starting Extracting Language Files from GoogleSheet - downloading csv approach..")

	gsheetURL := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQIhLNNfUKVjxMkMwdtTFnvuV8oN1H_OmgOWRCwHBkSfOo1fzA08LXDfcK4EA86fx18M4FeAIwOoBBR/pub?output=csv"

	csvRelFilePath := "./outputs/gsheet.csv"
	csvAbsFilePath, err := getAbsoluteFilePath(csvRelFilePath)

	err = getCSV(gsheetURL, csvAbsFilePath)
	if err != nil {
		log.Println(err)
		os.Exit(1)
	}


	jsonRelDirPath  := "./outputs/json"
	jsonAbsDirPath, err := getAbsoluteFilePath(jsonRelDirPath)

	log.Println("JSON Output directory: " + jsonAbsDirPath)

	err = s.WriteLanguageFiles(csvAbsFilePath, jsonAbsDirPath)
	if err != nil {
		log.Println(err)
		os.Exit(1)
	}

	log.Println("Completed Execution..")
}

func getAbsoluteFilePath(relFilePath string ) (result string, err error) {
	dir, err := os.Getwd()
	if err != nil {
		log.Fatal(err)
	}
	absFilePath := filepath.Join(dir, relFilePath)

	return absFilePath, nil

}


func getCSV(sourceURL string, targetFilePath string) (err error) {
	err = s.Download(sourceURL,targetFilePath,5000)
	return err
}


