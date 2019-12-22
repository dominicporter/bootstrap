package services

import (
	"encoding/csv"
	"encoding/json"
	"fmt"
	"strings"

	"io/ioutil"
	"log"
	"net/http"
	"net/url"
	"os"
	"path/filepath"
	"time"

	"github.com/pkg/errors"

	"github.com/tidwall/pretty"
)

var (
	// tags used when translate
	tagsToRemove = []string{"NOTRANSLATE_", "] (", "/ "}
	// tags to replace
	tagsToReplace = []string{"", "](", "/"}
)

// Hugo struct
type Hugo struct {
	Key    string
	Values [][]string
}

// do not edit this mapping
var mimeMap = map[string]string{
	"video/3gpp":         "3gp",
	"video/x-ms-asf":     "asf",
	"video/x-msvideo":    "avi",
	"image/bmp":          "bmp",
	"application/msword": "doc",
	"application/vnd.openxmlformats-officedocument.wordprocessingml.document": "docx",
	"application/vnd.ms-excel": "xls",
	"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet": "xlsx",
	"image/gif":                          "gif",
	"application/x-gtar":                 "gtar",
	"application/x-gzip":                 "gz",
	"text/html":                          "html",
	"image/jpeg":                         "jpg",
	"audio/x-mpegurl":                    "m3u",
	"audio/mp4a-latm":                    "m4a",
	"video/vnd.mpegurl":                  "m4u",
	"video/x-m4v":                        "m4v",
	"video/quicktime":                    "mov",
	"audio/x-mpeg":                       "mp3",
	"video/mp4":                          "mp4",
	"application/vnd.mpohun.certificate": "mpc",
	"video/mpeg":                         "mpeg",
	"audio/mpeg":                         "mpga",
	"application/vnd.ms-outlook":         "msg",
	"audio/ogg":                          "ogg",
	"application/pdf":                    "pdf",
	"image/png":                          "png",
	"application/vnd.ms-powerpoint":      "ppt",
	"application/vnd.openxmlformats-officedocument.presentationml.presentation": "pptx",
	"audio/x-pn-realaudio":         "rmvb",
	"application/rtf":              "rtf",
	"application/x-tar":            "tar",
	"application/x-compressed":     "tgz",
	"text/plain":                   "txt",
	"audio/x-wav":                  "wav",
	"audio/x-ms-wma":               "wma",
	"audio/x-ms-wmv":               "wmv",
	"application/x-compress":       "z",
	"application/x-zip-compressed": "zip",
	"*/*":                          "",
}

func GetAbsoluteFilePath(relFilePath string, sheet string) (result string, err error) {
	dir, err := os.Getwd()
	if err != nil {
		log.Fatal(sheet, " : ", err)
	}
	absFilePath := filepath.Join(dir, relFilePath)

	return absFilePath, nil

}

// TODO: Use the new error handling patterns
//var ErrPermission = errors.New("permission denied")

// Download exported
func Download(url string, filename string, timeout int64, sheet string, checkCSV bool) (err error) {

	// show line numbers
	log.SetFlags(log.LstdFlags | log.Lshortfile)

	//log.Println(sheet, " : ", "Downloading", url, "...")
	client := http.Client{
		Timeout: time.Duration(timeout * int64(time.Second)),
	}
	resp, err := client.Get(url)
	if err != nil {
		log.Println(sheet, " : ", "Cannot download file from the given url", err)
		return err
	}

	if resp.StatusCode != 200 {
		log.Printf("%v : Response from the URL was %d, but expecting 200", sheet, resp.StatusCode)
		return errors.New("Response returned with a status different from 200")
	}
	if checkCSV {
		if resp.Header["Content-Type"][0] != "text/csv" && resp.Header["Content-Type"][0] != "text/csv; charset=utf-8" {
			log.Printf(sheet, " : ", "The file downloaded has content type %s, expected text/csv", resp.Header["Content-Type"])
			return errors.New("Downloaded file didn't contain the expected content-type: text/csv")
		}
	}
	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Println(sheet, " : ", "Cannot read Body of Response", err)
		return errors.New("Cannot read Body of Response")
	}

	if !checkCSV {
		filename = filename + "." + mimeMap[resp.Header["Content-Type"][0]]
		log.Println(sheet, " : ", filename)
	}

	createFile(filename)

	err = ioutil.WriteFile(filename, b, 0644)
	if err != nil {
		log.Println(sheet, " : ", "Cannot write to file", err)
		return errors.New("Cannot write to file")
	}

	log.Println(sheet, " : ", "Doc downloaded in ", filename)

	return nil
}

// WriteLanguageFiles exported
func WriteLanguageFiles(csvFilePath string, jsonDirPath string, sheet string) error {
	csvFile, err := os.Open(csvFilePath)
	if err != nil {
		log.Println(sheet, " : ", "Cannot open file:"+csvFilePath, err)
		return errors.Wrap(err, sheet+" : "+"Cannot open file:"+csvFilePath)

	}
	// get csf file content
	csvFileContent, err := csv.NewReader(csvFile).ReadAll()
	if err != nil {
		return errors.New("Cannot read file:" + csvFilePath)
	}

	langFileName := "labels.json"

	langFilePath := filepath.Join(jsonDirPath, langFileName)

	langAbsPath, err := filepath.Abs(langFilePath)
	if err != nil {
		log.Println(sheet, " : ", "Cannot get path specified: \""+langAbsPath+"\"", err)
		return errors.New("Cannot get path specified:" + langFilePath)
	}

	createFile(langAbsPath)

	file, err := os.OpenFile(langAbsPath, os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Println(sheet, " : ", "Cannot open file: \""+langAbsPath+"\"", err)
		return errors.Wrap(err, sheet+" : "+"Cannot open file: \""+langAbsPath+"\"")
	}

	//log.Println("langAbsPath: \"" + langAbsPath + "\"")
	//os.Exit(1)

	err = file.Truncate(0)
	if err != nil {
		return errors.New("Cannot truncate file:")
	}
	mapFull := map[string]map[string]string{}
	// walk content for each lang
	for i, lang := range csvFileContent[0][1:] {

		mapLn := map[string]string{}
		log.Println("Language : ", lang, i)
		for j, row := range csvFileContent[1:] {
			// fmt.Println(csvFileContent[j+1][0], row[i+1])
			mapLn[csvFileContent[j+1][0]] = row[i+1]
		}
		mapFull[lang] = mapLn
	}
	encodedJSON, _ := json.Marshal(mapFull)
	// log.Println(string(encodedJSON))

	_, err = file.Write(FormatJSON(encodedJSON))
	if err != nil {
		return errors.New("Cannot write to file:")
	}
	err = file.Close()
	if err != nil {
		return errors.New("Cannot Close to file:")
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

	//log.Println("==> done creating file", path)
}

func isError(err error) bool {
	if err != nil {
		log.Println(err.Error())
	}

	return err != nil
}

// WriteDataDumpFiles exported
func WriteDataDumpFiles(csvFilePath string, jsonDirPath string, sheet string) error {
	csvFile, err := os.Open(csvFilePath)
	if err != nil {
		log.Println(sheet, " : ", "Cannot open file:"+csvFilePath, err)
		return errors.Wrap(err, "Cannot open file:"+csvFilePath)

	}
	// get csf file content
	csvFileContent, err := csv.NewReader(csvFile).ReadAll()
	if err != nil {
		return errors.New("Cannot read file:" + csvFilePath)
	}
	keys := csvFileContent[0][0:]
	// walk content for each lang
	var data []map[string]string
	for rowIndex, row := range csvFileContent[1:][0:] {
		data = append(data, map[string]string{})
		for columnIndex, key := range keys {
			if strings.Contains(key, "_url") && strings.TrimSpace(row[columnIndex]) != "" {
				u, err := url.Parse(row[columnIndex])
				if err != nil {
					data[rowIndex][key] = "error downloading"
					panic(err)
				} else {
					m, _ := url.ParseQuery(u.RawQuery)
					if m.Get("id") != "" {
						link := fmt.Sprintf("https://drive.google.com/uc?authuser=0&id=%v&export=download", m["id"][0])
						AbsFilePath, err := GetAbsoluteFilePath("./outputs/datadump/json/"+sheet+"/"+m["id"][0], sheet)
						err = Download(link, AbsFilePath, 5000, sheet, false)
						if err != nil {
							log.Println(sheet, " : ", err)
							data[rowIndex][key] = "error downloading"
						} else {
							data[rowIndex][key] = "assets/mockData/" + sheet + "/" + m["id"][0] + ".png"
						}
					}
				}

			} else {
				data[rowIndex][key] = row[columnIndex]
			}

		}
	}
	FileName := sheet + ".json"

	FilePath := filepath.Join(jsonDirPath, FileName)

	AbsPath, err := filepath.Abs(FilePath)
	if err != nil {
		log.Println(sheet, " : ", "Cannot get path specified: \""+AbsPath+"\"", err)
		return errors.New("Cannot get path specified:" + FilePath)
	}

	createFile(AbsPath)

	file, err := os.OpenFile(AbsPath, os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Println(sheet, " : ", "Cannot open file: \""+AbsPath+"\"", err)
		return errors.Wrap(err, "Cannot open file: \""+AbsPath+"\"")
	}

	err = file.Truncate(0)
	if err != nil {
		return errors.New("Cannot truncate file:" + sheet)
	}
	encodedJSON, _ := json.Marshal(data)

	_, err = file.Write(FormatJSON(encodedJSON))
	if err != nil {
		return errors.New("Cannot write to file:" + sheet)
	}
	err = file.Close()
	if err != nil {
		return errors.New("Cannot Close to file:" + sheet)
	}
	return nil
}

// FormatJSON formats the JSON to be tidy and readable
func FormatJSON(json []byte) (result []byte) {
	result = pretty.Pretty(json)
	return result
}

// WriteHugoFiles exported
func WriteHugoFiles(csvFilePath, hugoDirPath, sheet string) error {

	// open csv file
	csvFile, err := os.Open(csvFilePath)

	if err != nil {
		log.Println(sheet, " : ", "Cannot open file:"+csvFilePath, err)
		return errors.Wrap(err, "Cannot open file:"+csvFilePath)
	}

	// get csv file content
	csvFileContent, err := csv.NewReader(csvFile).ReadAll()

	if err != nil {
		return errors.New("Cannot read file:" + csvFilePath)
	}

	// out dirs content and i18n paths
	i18nDir := hugoDirPath + "i18n/"
	contentDir := hugoDirPath + "content/"

	// create dirs
	mkDirIfNotExists(i18nDir)
	mkDirIfNotExists(contentDir)

	// loop through csv file
	for index, lang := range csvFileContent[0][1:] {

		index++
		cache := make(map[string]int)
		langHugo := []Hugo{}

		for _, row := range csvFileContent[1:] {

			// check if key is an markdown file
			if strings.Split(row[0], ".")[1] == "md" {
				err = mkDirIfNotExists(contentDir + lang + "/")
				if err != nil {
					return err
				}

				mdFile, err := os.OpenFile(contentDir+lang+"/"+row[0], os.O_RDWR|os.O_CREATE, 0700)

				if err != nil {
					return err
				}

				// clean string by removing all tags
				cleanedData := row[index]

				for tagIndex, tag := range tagsToRemove {
					cleanedData = strings.ReplaceAll(cleanedData, tag, tagsToReplace[tagIndex])
				}

				// write to lang file
				err = mdFile.Truncate(0)

				if err != nil {
					return errors.New("Cannot truncate file:" + sheet)
				}

				_, err = mdFile.Write([]byte(cleanedData))

				if err != nil {
					return errors.New("Cannot write to file:" + sheet)
				}
				mdFile.Close()
				continue
			}

			h := Hugo{}

			if strings.Contains(row[0], "(") {

				// Check if row contains hugo multi values
				sp := strings.Split(row[0], "(")
				tr := strings.TrimRight(sp[1], ")")
				sp2 := strings.Split(tr, ".")

				// if there is already a hugo object with the same key in cache
				// so get index from cache and append to to values array
				if i, ok := cache[cleanKey(sp[0])]; ok {
					val := []string{sp2[1], row[index]}
					langHugo[i].Values = append(langHugo[i].Values, val)
					continue
				}

				h = Hugo{Key: cleanKey(sp[0]), Values: [][]string{{sp2[1], row[index]}}}

			} else {
				h = Hugo{Key: cleanKey(row[0]), Values: [][]string{{"other", row[index]}}}
			}

			langHugo = append(langHugo, h)
			cache[h.Key] = len(langHugo) - 1

		}

		hugoFormat := ""
		// populate hugo object
		for _, item := range langHugo {

			hugoFormat += "[" + item.Key + "]\n"
			for _, val := range item.Values {
				hugoFormat += val[0] + " = \"" + val[1] + "\"\n"
			}
			hugoFormat += "\n"
		}

		outFilePath := i18nDir + lang + ".toml"
		file, err := os.OpenFile(outFilePath, os.O_RDWR|os.O_CREATE, 0777)

		if err != nil {
			log.Println("Error file:"+outFilePath, err)
			return err
		}

		// write to lang file
		err = file.Truncate(0)

		if err != nil {
			return fmt.Errorf("Cannot truncate file: %v", err)
		}

		_, err = file.Write([]byte(hugoFormat))

		if err != nil {
			return fmt.Errorf("Cannot write to file: %v", err)
		}
		file.Close()
	}

	return nil
}

func mkDirIfNotExists(path string) error {
	if _, err := os.Stat(path); os.IsNotExist(err) {
		err := os.MkdirAll(path, 0777)
		if err != nil {
			fmt.Println("Cannot create directory:", err)
			return err
		}
	}
	return nil
}

func cleanKey(key string) string {
	return strings.ReplaceAll(key, ".", "_")
}
