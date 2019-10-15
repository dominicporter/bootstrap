// Runs the test suite against the repo
func Test() error {
	return commands.Test("./...")
}

// Checks for copyright headers in files
func CheckCopyright() error {
	return commands.Copyright("./...")
}

// Checks for issues with go imports
func CheckGoImports() error {
	return commands.GoImports("./...")
}

// Reports linting errors in the solution
func CheckGoLint() error {
	return commands.GoLint("./...")
}

// Updates the go report for the repo
func CheckGoReport() error {
	return commands.GoReport("github.com/your-name/your-repo")
}

// Checks that the source is compliant with go vet
func CheckGoVet() error {
	return commands.GoVet("./...")
}

// Checks that the source is compliant with go vet
func Check() error {
	return commands.Check("./...")
}