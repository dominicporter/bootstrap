package util

import (
	"bytes"
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
func (Windows) InstallDependency() (err error) {
	posh := New()
	//	var stdout,stderr string
	_, _, err = posh.Execute("Set-ExecutionPolicy RemoteSigned -scope CurrentUser")
	if err != nil {
		return
	}
	_, _, err = posh.Execute("Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')")
	if err != nil {
		return
	}
	_, _, err = posh.Execute("scoop update")
	if err != nil {
		return
	}
	_, _, err = posh.Execute("scoop install aria2")
	if err != nil {
		return
	}
	_, _, err = posh.Execute("scoop bucket add extras")
	if err != nil {
		return
	}
	_, _, err = posh.Execute("scoop install git")
	if err != nil {
		return
	}
	_, _, err = posh.Execute("scoop install which")
	if err != nil {
		return
	}
	_, _, err = posh.Execute("scoop install make")
	if err != nil {
		return
	}
	_, _, err = posh.Execute("scoop install vscode")
	if err != nil {
		return
	}
	_, _, err = posh.Execute("scoop install protobuf")
	if err != nil {
		return
	}
	_, _, err = posh.Execute("scoop install gcc")
	if err != nil {
		return
	}
	_, _, err = posh.Execute("scoop install flutter")
	if err != nil {
		return
	}
	return
}

//https://stackoverflow.com/questions/50809752/golang-invoking-powershell-exe-always-returns-ascii-characters
