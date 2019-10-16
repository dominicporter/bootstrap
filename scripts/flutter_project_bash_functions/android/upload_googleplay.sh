echo "preparing to upload to Google Play"
flutter clean
flutter packages get
flutter build appbundle --target-platform android-arm,android-arm64xcodebuild --status
echo "Uploading to Google Play"
# does this in the projects android folder..
android/gradlew publishBundle
echo "Upload complete"
flutter clean
echo "Script finished"