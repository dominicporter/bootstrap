package services

import (
	"encoding/csv"
	"encoding/json"

	"io/ioutil"
	"log"
	"net/http"
	"os"
	"path/filepath"
	"time"

	"github.com/pkg/errors"
)

func GetAbsoluteFilePath(relFilePath string) (result string, err error) {
	dir, err := os.Getwd()
	if err != nil {
		log.Fatal(err)
	}
	absFilePath := filepath.Join(dir, relFilePath)

	return absFilePath, nil

}

// TODO: Use the new error handling patterns
//var ErrPermission = errors.New("permission denied")

// Download exported
func Download(url string, filename string, timeout int64) (err error) {

	// show line numbers
	log.SetFlags(log.LstdFlags | log.Lshortfile)

	log.Println("Downloading", url, "...")
	client := http.Client{
		Timeout: time.Duration(timeout * int64(time.Second)),
	}
	resp, err := client.Get(url)
	if err != nil {
		log.Println("Cannot download file from the given url", err)
		return err
	}

	if resp.StatusCode != 200 {
		log.Printf("Response from the URL was %d, but expecting 200", resp.StatusCode)
		return errors.New("Response returned with a status different from 200")
	}
	if resp.Header["Content-Type"][0] != "text/csv" {
		log.Printf("The file downloaded has content type '%s', expected 'text/csv'.", resp.Header["Content-Type"])
		return errors.New("Downloaded file didn't contain the expected content-type: 'text/csv'")
	}

	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Println("Cannot read Body of Response", err)
		return errors.New("Cannot read Body of Response")
	}

	createFile(filename)

	err = ioutil.WriteFile(filename, b, 0644)
	if err != nil {
		log.Println("Cannot write to file", err)
		return errors.New("Cannot write to file")
	}

	log.Println("Doc downloaded in ", filename)

	return nil
}

// WriteLanguageFiles exported
func WriteLanguageFiles(csvFilePath string, jsonDirPath string) error {
	csvFile, err := os.Open(csvFilePath)
	if err != nil {
		log.Println("Cannot open file:"+csvFilePath, err)
		return errors.Wrap(err, "Cannot open file:"+csvFilePath)

	}
	// get csf file content
	csvFileContent, err := csv.NewReader(csvFile).ReadAll()
	if err != nil {
		return errors.New("Cannot read file:" + csvFilePath)
	}

	// walk content for each lang
	for i, lang := range csvFileContent[0][1:] {
		langFileName := lang + ".json"

		langFilePath := filepath.Join(jsonDirPath, langFileName)

		langAbsPath, err := filepath.Abs(langFilePath)
		if err != nil {
			log.Println("Cannot get path specified: \""+langAbsPath+"\"", err)
			return errors.New("Cannot get path specified:" + langFilePath)
		}

		createFile(langAbsPath)

		file, err := os.OpenFile(langAbsPath, os.O_CREATE|os.O_WRONLY, 0644)
		if err != nil {
			log.Println("Cannot open file: \""+langAbsPath+"\"", err)
			return errors.Wrap(err, "Cannot open file: \""+langAbsPath+"\"")
		}

		//log.Println("langAbsPath: \"" + langAbsPath + "\"")
		//os.Exit(1)

		err = file.Truncate(0)
		if err != nil {
			return errors.New("Cannot truncate file:" + lang)
		}
		mapLn := map[string]string{}
		log.Println("Language:", lang, i)
		for j, row := range csvFileContent[1:] {
			// fmt.Println(csvFileContent[j+1][0], row[i+1])
			mapLn[csvFileContent[j+1][0]] = row[i+1]
		}
		encodedJSON, _ := json.Marshal(mapLn)
		// log.Println(string(encodedJSON))
		_, err = file.Write(encodedJSON)
		if err != nil {
			return errors.New("Cannot write to file:" + lang)
		}
		err = file.Close()
		if err != nil {
			return errors.New("Cannot Close to file:" + lang)
		}
	}
	return nil
}

func createFile(path string) {
	if _, err := os.Stat(path); os.IsNotExist(err) {
		// create dir (or 0755)
		dir := filepath.Dir(path)
		err = os.MkdirAll(dir, 0700)
		if isError(err) {
			return
		}
		// Create your file
		var file, err = os.Create(path)
		if isError(err) {
			return
		}
		defer file.Close()
	}

	log.Println("==> done creating file", path)
}

/*func createDirectory(dirName string) bool {
	src, err := os.Stat(dirName)

	if os.IsNotExist(err) {
		// is recursive
		errDir := os.MkdirAll(dirName, 0755)
		if errDir != nil {
			panic(err)
		}
		return true
	}

	if src.Mode().IsRegular() {
		log.Println(dirName, "already exist as a file!")
		return false
	}

	return false
}*/

func isError(err error) bool {
	if err != nil {
		log.Println(err.Error())
	}

	return err != nil
}
