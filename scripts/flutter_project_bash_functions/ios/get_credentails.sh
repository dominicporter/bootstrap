FILEPATH=~/Dropbox/cloudDev/app_store_credentials.txt
#!/bin/ksh
file=$FILEPATH
while IFS= read line
do
    var="$line"
    KEY=$(echo $var | awk '{print $1}')
    VALUE=$(echo $var | awk '{print $2}')

    echo "KEY IS $KEY and VALUE is $VALUE"

    if [ $KEY == "IOS_APP_STORE_USERNAME" ]
    then
        IOS_UN=$VALUE
    elif [ $KEY == "IOS_APP_STORE_PASSWORD" ]
    then
        IOS_PW=$VALUE
    elif [  $KEY == "GOOLE_PLAY_STORE_USERNAME" ]
    then
        GP_UN=$VALUE
    elif [  $KEY == "GOOLE_PLAY_STORE_PASSWORD" ]
    then
        GP_PW=$VALUE
    fi

done <$file

echo "iOS Credentials are username: ${IOS_UN} and password: ${IOS_PW}"
echo "Google Credentials are username: ${GP_UN} and password: ${GP_PW}"
