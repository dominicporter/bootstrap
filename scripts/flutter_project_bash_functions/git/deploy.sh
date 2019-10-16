read -r -p 'Commit message: ' desc
git add .
git add -u
git commit -m "$desc"
git push 
