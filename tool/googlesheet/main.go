package main

import (
	Services "github.com/winwisely99/bootstrap/tool/googlesheet/services"
	"log"
	"os"
)

func main() {

	// show line numbers
	log.SetFlags(log.LstdFlags | log.Lshortfile)

	log.Println("Starting Extracting Language Files from GoogleSheet - downloading csv approach..")

	gsheetURL := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQIhLNNfUKVjxMkMwdtTFnvuV8oN1H_OmgOWRCwHBkSfOo1fzA08LXDfcK4EA86fx18M4FeAIwOoBBR/pub?output=csv"

	csvRelFilePath := "./outputs/gsheet.csv"
	csvAbsFilePath, err := Services.GetAbsoluteFilePath(csvRelFilePath)

	err = Services.Download(gsheetURL, csvAbsFilePath, 5000)
	if err != nil {
		log.Println(err)
		os.Exit(1)
	}

	jsonRelDirPath := "./outputs/json"
	jsonAbsDirPath, err := Services.GetAbsoluteFilePath(jsonRelDirPath)

	log.Println("JSON Output directory: " + jsonAbsDirPath)

	err = Services.WriteLanguageFiles(csvAbsFilePath, jsonAbsDirPath)
	if err != nil {
		log.Println(err)
		os.Exit(1)
	}

	log.Println("Completed Execution..")
}
