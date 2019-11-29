package main

import (
	"fmt"
	yml "gopkg.in/yaml.v2"
	"io/ioutil"
)

var env map[interface{}]interface{}

func init() {
	env = make(map[interface{}]interface{})

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
	for k, v := range env {
		fmt.Println(k, ": ", v)
	}
}
