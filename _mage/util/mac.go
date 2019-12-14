package util

import (
	"github.com/fatih/color"
	"github.com/magefile/mage/mg"
	"github.com/magefile/mage/sh"
)

type Mac mg.Namespace

func (Mac) InstallDependency() {
	if err := sh.Run("xcode-select", "--install"); err != nil {
		color.Red(err.Error())
	}
	if err := sh.Run("/usr/bin/ruby", "-e", "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"); err != nil {
		color.Red(err.Error())
	}
	if err := sh.Run("brew", "upgrade"); err != nil {
		color.Red(err.Error())
	}
	if err := sh.Run("brew", "install", "git"); err != nil {
		color.Red(err.Error())
	}
	if err := sh.Run("xcode-select", "--install"); err != nil {
		color.Red(err.Error())
	}
	if err := sh.Run("brew", "cask", "install visual-studio-code"); err != nil {
		color.Red(err.Error())
	}
	if err := sh.Run("brew", "install", "protobuf"); err != nil {
		color.Red(err.Error())
	}
	if err := sh.Run("brew", "install", "gcc"); err != nil {
		color.Red(err.Error())
	}
	if err := sh.Run("brew", "install", "--HEAD", "libimobiledevice"); err != nil {
		color.Red(err.Error())
	}
	if err := sh.Run("brew", "install", "ideviceinstaller", "ios-deploy", "cocoapods"); err != nil {
		color.Red(err.Error())
	}
	if err := sh.Run("pod", "setup"); err != nil {
		color.Red(err.Error())
	}
	if err := sh.Run("brew", "cask", "install", "adoptopenjdk"); err != nil {
		color.Red(err.Error())
	}
	if err := sh.Run("brew", "cask", "install", "android-studio"); err != nil {
		color.Red(err.Error())
	}
	if err := sh.Run("cd", "$(HOME)/workspace", "&&", "git", "clone", "-b", "master", "https://github.com/flutter/flutter.git"); err != nil {
		color.Red(err.Error())
	}

	if err := sh.RunV("./flutter/bin/flutter", "--version"); err != nil {
		color.Red(err.Error())
	}

}
