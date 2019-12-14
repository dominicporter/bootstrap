package util

import (
	"bytes"
	"github.com/fatih/color"
	"github.com/magefile/mage/mg"
	"os/exec"
)

type Windows mg.Namespace

type PowerShell struct {
	powerShell string
}

func New() *PowerShell {
	ps, _ := exec.LookPath("powershell.exe")
	return &PowerShell{
		powerShell: ps,
	}
}

func (p *PowerShell) Execute(args ...string) (stdOut string, stdErr string, err error) {
	args = append([]string{"-NoProfile", "-NonInteractive"}, args...)
	cmd := exec.Command(p.powerShell, args...)

	var stdout bytes.Buffer
	var stderr bytes.Buffer
	cmd.Stdout = &stdout
	cmd.Stderr = &stderr

	err = cmd.Run()
	stdOut, stdErr = stdout.String(), stderr.String()
	return
}
func (Windows) InstallDependency() {
	var err error
	posh := New()
	//	var stdout,stderr string
	_, _, err = posh.Execute("Set-ExecutionPolicy RemoteSigned -scope CurrentUser")
	color.Red(err.Error())

	_, _, err = posh.Execute("Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')")
	color.Red(err.Error())

	_, _, err = posh.Execute("scoop update")
	color.Red(err.Error())

	_, _, err = posh.Execute("scoop install aria2")
	color.Red(err.Error())

	_, _, err = posh.Execute("scoop bucket add extras")
	color.Red(err.Error())

	_, _, err = posh.Execute("scoop install git")
	color.Red(err.Error())

	_, _, err = posh.Execute("scoop install which")
	color.Red(err.Error())

	_, _, err = posh.Execute("scoop install make")
	color.Red(err.Error())

	_, _, err = posh.Execute("scoop install vscode")
	color.Red(err.Error())

	_, _, err = posh.Execute("scoop install protobuf")
	color.Red(err.Error())

	_, _, err = posh.Execute("scoop install gcc")
	color.Red(err.Error())

	_, _, err = posh.Execute("scoop install flutter")
	color.Red(err.Error())

}

//https://stackoverflow.com/questions/50809752/golang-invoking-powershell-exe-always-returns-ascii-characters
