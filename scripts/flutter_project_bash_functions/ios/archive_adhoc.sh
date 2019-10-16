START=`date +%s`

ARCHIVE_PATH="/Users/$HOME/Library/Developer/Xcode/Archives/`date +"%Y-%m-%d"`/Runner_`date +"%Y-%m-%d_%H%M"`"
DERIVEDDATAPATH="/Users/$HOME/Library/Developer/Xcode/DerivedData"
WORKSPACEPATH="./ios/Runner.xcworkspace"
SCHEME="release"
EXPORTOPTIONSPLISTPATH="./ios/Runner/exportOptionsAdHoc.plist"
EXPORTPATH="./build/ios/Runner_`date +"%Y-%m-%d_%H%M"`_IPA"
PROJECTPATH="./ios"
APP_NAME="Runner"

FILEPATH=~/Dropbox/cloudDev/app_store_credentials.txt
#!/bin/ksh
file=$FILEPATH
while IFS= read line
do
    var="$line"
    KEY=$(echo $var | awk '{print $1}')
    VALUE=$(echo $var | awk '{print $2}')

    if [ $KEY == "IOS_APP_STORE_USERNAME" ]
    then
        USERNAME=$VALUE
    elif [ $KEY == "IOS_APP_STORE_PASSWORD" ]
    then
        PASSWORD=$VALUE
    elif [ $KEY == "DIAL_IN_PASSWORD" ]
    then
        DIAL_IN_PASSWORD=$VALUE
    elif [ $KEY == "ALTOOL_PASSWORD" ]
    then
        ALTOOL_PASSWORD=$VALUE
    elif [ $KEY == "DIAL_IN_BUNDLE_PASSWORD" ]
    then
        DIAL_IN_BUNDLE_PASSWORD=$VALUE
    fi
done <$file

echo "iOS Credentials are username: ${USERNAME} and password: ${PASSWORD}"

echo ""
echo "The Derived data path is $DERIVEDDATAPATH"
echo ""

echo "Deleting derived data"
rm -r $DERIVEDDATAPATH
echo "Xcode DerivedData removed"
echo ""

# Update app version
bin/update_version.sh


echo "Refreshing flutter"
flutter clean
flutter packages get
flutter build ios --release
echo ""

echo "The workspace path is $WORKSPACEPATH"
echo "The archive path is $ARCHIVE_PATH"
echo "The Scheme name is $SCHEME"
echo "Archiving"
echo ""
xcodebuild -workspace $WORKSPACEPATH -scheme $SCHEME clean archive -configuration Release -sdk iphoneos -archivePath $ARCHIVE_PATH
echo ""
echo "Finished archiving"

echo "Validating archieve with username $USERNAME and $DIAL_IN_BUNDLE_PASSWORD"
echo ""
altool --validate-app -f $ARCHIVE_PATH -t platform -u $USERNAME -p $DIAL_IN_BUNDLE_PASSWORD
echo ""

ARCHIVE_PATH="${ARCHIVE_PATH}.xcarchive"
echo "The new archive path is $ARCHIVE_PATH"
echo "The export options plist path is $EXPORTOPTIONSPLISTPATH"
echo "The export path is $EXPORTPATH"
echo "Exporting archive to IPA"
echo ""
xcodebuild -exportArchive -allowProvisioningUpdates -allowProvisioningDeviceRegistration -archivePath "$ARCHIVE_PATH" -exportOptionsPlist  $EXPORTOPTIONSPLISTPATH -exportPath $EXPORTPATH
echo ""
echo "Finished exporting archive to IPA"
echo ""

# flutter clean
END=`date +%s`
RUNTIME=$((end-start))

echo "Script finished in $RUNTIME seconds"



