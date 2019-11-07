// from: https://github.com/vova616/screenshot/blob/master/example/ss.go

package main

import (
	"fmt"
	"image/png"
	"log"
	"os"
	"path/filepath"

	"github.com/vova616/screenshot"
)

func main() {
	img, err := screenshot.CaptureScreen()
	if err != nil {
		panic(err)
	}

	// make out dir
	dir, err := os.Getwd()
	if err != nil {
		log.Fatal(err)
	}
	dirPath := filepath.Join(dir, "./bin/out")
	fmt.Println("dirPath:", dirPath)
	err = os.MkdirAll(dirPath, os.ModePerm)
	if err != nil {
		log.Fatal(err)
	}

	filePath := filepath.Join(dirPath, "ss.png")
	fmt.Println("filePath:", filePath)

	//os.Exit(1)

	// make file

	f, err := os.Create(filePath)
	if err != nil {
		panic(err)
	}
	err = png.Encode(f, img)
	if err != nil {
		panic(err)
	}
	f.Close()
}
