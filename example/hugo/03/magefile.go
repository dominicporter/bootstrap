// +build mage

package main

import "github.com/magefile/mage/sh"
import "github.com/magefile/mage/mg"

func init() {

}



func downloadDeps() error {
	//return sh.RunV("go", "mod", "download")

	// hugo

	// other ?
	return nil
}

func generate() error {
	return sh.RunV("go", "generate", "./...")
}

func Run() error {
	mg.Deps(downloadDeps, generate)
	// cd $(LIB_FSPATH) && hugo server -F
	return sh.RunV("hugo", "server", "-F")
}

func Test() error {
	mg.Deps(downloadDeps, generate)
	return sh.RunV("go", "test", "./...")
}

func Build() error {
	mg.Deps(Test)
	return sh.RunV("go", "build", "./...")
}
