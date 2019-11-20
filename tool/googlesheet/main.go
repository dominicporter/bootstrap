package main

import (
	"flag"
	"log"
	"sync"

	Services "github.com/winwisely99/bootstrap/tool/googlesheet/services"
	"github.com/winwisely99/bootstrap/tool/googlesheet/services/config"
)

func main() {
	log.SetFlags(log.LstdFlags | log.Lshortfile)
	// process lang by default
	option := flag.String("option", "lang", "a string")
	flag.Parse()
	switch *option {
	case "lang":
		processConfig(*option)
	case "datadump":
		processConfig(*option)
	case "hugo":
		//processConfig(*option)
		log.Println("Invalid Option")
	default:
		log.Println("Invalid Option ", *option)
	}
	log.Println("Completed Execution..")
}
func processConfig(option string) {
	Setting, err := config.New(option)
	if err != nil {
		log.Println("No conf file founded ", option)
		return
	}
	//fmt.Printf("%+v", Setting)
	log.Println("Starting Extracting Language Files from GoogleSheet - downloading csv approach..")
	var wg sync.WaitGroup
	for item := range Setting.GoogleSheet {
		wg.Add(1)
		go func(sheet string) {
			gsheetURL := Setting.GoogleSheet[sheet].CSV
			csvRelFilePath := "./outputs/" + option + "/" + sheet + ".csv"
			csvAbsFilePath, err := Services.GetAbsoluteFilePath(csvRelFilePath, sheet)

			err = Services.Download(gsheetURL, csvAbsFilePath, 5000, sheet)
			if err != nil {
				log.Println(sheet, " : ", err)
				wg.Done()
				return
			}

			jsonRelDirPath := "./outputs/" + option + "/json/" + sheet + "/"
			jsonAbsDirPath, err := Services.GetAbsoluteFilePath(jsonRelDirPath, sheet)

			log.Println(sheet, " JSON Output directory: "+jsonAbsDirPath)
			switch option {
			case "lang":
				err = Services.WriteLanguageFiles(csvAbsFilePath, jsonAbsDirPath, sheet)
				if err != nil {
					log.Println(sheet, " : ", err)
					wg.Done()
					return
				}
			case "datadump":
				err = Services.WriteDataDumpFiles(csvAbsFilePath, jsonAbsDirPath, sheet)
				if err != nil {
					log.Println(sheet, " : ", err)
					wg.Done()
					return
				}
			case "hugo":
				//processConfig(*option)
				log.Println("Invalid Option ", option)
			default:
				log.Println("Invalid Option ", option)
			}

			wg.Done()
		}(item)

	}
	wg.Wait()
}

func processFile() {

}
