package main

import (
	"fmt"
	"github.com/magefile/mage/sh"
	yml "gopkg.in/yaml.v2"
	"io/ioutil"
	"os"
)

var env map[string]string

func init() {
	env = make(map[string]string)

	fileContent, err := ioutil.ReadFile("env.yml") // just pass the file name
	if err != nil {
		fmt.Println("env.yml File not found")
	}
	err = yml.Unmarshal(fileContent, &env)
	if err != nil {
		fmt.Println("env.yml Is not well structured.")

	}
}

//Print
func Print() {
	GOPATH := os.Getenv("GOPATH")
	LIB_NAME := os.Getenv("LIB_NAME")
	LIB := "github.com/winwisely99/" + env["LIB_NAME"]

	fmt.Println("LIB_NAME: ", env["LIB_NAME"])
	fmt.Println("LIB: ", LIB)
	fmt.Println("LIB_BRANCH: ", env["LIB_BRANCH"])
	fmt.Println("LIB_FSPATH: ", GOPATH+"/src/"+LIB)
	fmt.Println("SAMPLE_NAME: ", env["SAMPLE_NAME"])
	fmt.Println("SAMPLE_FSPATH: ", GOPATH+"/src/"+LIB+"/"+env["SAMPLE_NAME"])
	fmt.Println("GOOGLE_SHEET_ID: ", env["GOOGLE_SHEET_ID"])
	fmt.Println("GOOGLE_SHEET_URL: ", env["GOOGLE_SHEET_URL"])
	fmt.Println("GOOGLE_SHEET_CSV: ", env["GOOGLE_SHEET_CSV"])

	fmt.Println("IB: ", "github.com/winwisely99/"+LIB_NAME)

}

// Test
func Test() {
	out, err := sh.Output("go", "test", "-v", "./...")
	fmt.Println("Test err :", err)
	fmt.Println(out)
}
