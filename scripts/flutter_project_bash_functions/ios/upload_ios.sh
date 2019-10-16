EXPORTPATH=$1

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

echo "Uploading with Username: ${USERNAME} and password ${DIAL_IN_PASSWORD}"
echo "File to upload: ${EXPORTPATH}"
echo ""
altool --upload-app -f $EXPORTPATH -u $USERNAME -p $PASSWORD
echo ""