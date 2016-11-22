set datetimef=%date:~-4%.%date:~3,2%.%date:~0,2%__%time:~0,2%:%time:~3,2%:%time:~6,2%
echo %datetimef%
git pull
git add -A
git commit -m "%datetimef%"
git push