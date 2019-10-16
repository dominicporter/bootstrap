ARCHIVE_PATH="/Users/$HOME/Library/Developer/Xcode/Archives/`date +"%Y-%m-%d"`/Runner_`date +"%Y-%m-%d_%H%M"`"
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
    fi
done <$file

echo "iOS Credentials are username: ${USERNAME} and password: ${PASSWORD}"

echo "Validating archieve with username $USERNAME and $DIAL_IN_PASSWORD"
echo ""
# altool --validate-app -v -f $ARCHIVE_PATH -t platform -u $USERNAME -p $DIAL_IN_PASSWORD
altool --validate-app -v -f $ARCHIVE_PATH -t platform -u $USERNAME -p "qldh-slsq-benl-ewhj"

# altool --validate-app -f $ARCHIVE_PATH -t platform -u $USERNAME -p $PASSWORD
# altool --validate-app -f $ARCHIVE_PATH
echo ""ß