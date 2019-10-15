# win

1. run bootstrap.ps1 in Powershell.

2. Set Env for golang
User Level:
GOROOT = C:\Users\HOME\scoop\apps\go\current

System Level:
PATH to have: C:\Users\Saadi\scoop\apps\go\current\bin

3. Check golang works
- Run the example.




# OTHER....
go-releaser can release to scoop:
- https://godoc.org/github.com/goreleaser/goreleaser/internal/pipe/scoop
- so we can release to a private scoop and then update apps this way.