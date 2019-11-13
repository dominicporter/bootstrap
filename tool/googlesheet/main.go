package main

import (
	"flag"
	Services "github.com/winwisely99/bootstrap/tool/googlesheet/services"
	"log"
	"os"
	"strconv"
	TimeLib "time"
)

func main() {

	// show line numbers
	log.SetFlags(log.LstdFlags | log.Lshortfile)
	Url := flag.String("url", "empty", "Url of googleSheet")
	flag.Parse()
	if *Url == "empty" {
		log.Println("\nBad input.\nPlease enter valid url.")
		return

	}
	log.Println("Starting Extracting Language Files from GoogleSheet - downloading csv approach..")
	//gsheetURL := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQIhLNNfUKVjxMkMwdtTFnvuV8oN1H_OmgOWRCwHBkSfOo1fzA08LXDfcK4EA86fx18M4FeAIwOoBBR/pub?output=csv"
	gsheetURL := *Url
	timeStamp := TimeLib.Now().Unix()
	csvRelFilePath := "./outputs/" + strconv.FormatInt(timeStamp, 10) + "-gsheet.csv"
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
