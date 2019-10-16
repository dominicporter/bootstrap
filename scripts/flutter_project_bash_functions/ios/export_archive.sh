ARCHIVEPATH="/Users/$HOME/Library/Developer/Xcode/Archives/`date +"%Y-%m-%d"`/Runner `date +"%Y-%m-%d %H:%M"`"
EXPORTOPTIONSPLISTPATH="/Users/$HOME/dev/FlutterProjects/dial_in_v1/ios/Runner/exportOptions.plist"
EXPORTPATH="/Users/$HOME/dev/FlutterProjects/dial_in_v1/ios/Runner.ipa"


echo ""
echo "The archive path is $ARCHIVEPATH"
echo "The export options plist path is $EXPORTOPTIONSPLISTPATH"
echo "The export path is $EXPORTPATH"
echo ""

echo "Exporting archive"
xcodebuild -exportArchive -archivePath $ARCHIVEPATH -exportOptionsPlist  $EXPORTOPTIONSPLISTPATH -exportPath  $EXPORTPATH