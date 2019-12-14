package main

import (
	"fmt"
	mageutil "github.com/winwisely99/bootstrap/_mage/util"
	"os"
)

var curDir = func() string {
	name, _ := os.Getwd()
	return name
}()

func WindowsDependency() {
	err := mageutil.Windows{}.InstallDependency()
	if err != nil {
		fmt.Println("Error in install windows dependency.")
	}
}
