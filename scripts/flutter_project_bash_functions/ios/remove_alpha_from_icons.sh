cd ios/Runner/Assets.xcassets/AppIcon.appiconset
for i in `ls *.png`; do convert $i -background black -alpha remove -alpha off $i; done