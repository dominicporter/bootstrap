#!/bin/ksh

FILE="${PWD}/pubspec.yaml"
while IFS= read line
do
    var="$line"
    KEY=$(echo $var | awk '{print $1}')
    VALUE=$(echo $var | awk '{print $2}')

    if [ "$KEY" == "version:" ]
    then
        APP_DETAILS=$VALUE
    fi

done <$FILE

APP_VERSION=$(echo $APP_DETAILS | awk -F'+' '{print $1}')
BUILD_NUMBER=$(echo $APP_DETAILS | awk -F'+' '{print $2}')

PRIMARY_VERSION=$(echo $APP_VERSION | awk -F'.' '{print $1}')
SECONDERY_VERSION=$(echo $APP_VERSION | awk -F'.' '{print $2}')
LOWER_VERSION=$(echo $APP_VERSION | awk -F'.' '{print $3}')


let "NEW_BUILD_NUMBER=BUILD_NUMBER + 1"


if [ "$LOWER_VERSION" -ge 9 ]
    then
    LOWER_VERSION=0
        if [ "$SECONDERY_VERSION" -ge 9 ]
            then
            SECONDERY_VERSION=0
            if [ "$PRIMARY_VERSION" -ge 9 ]
                then
                PRIMARY_VERSION=0
            else
                let "PRIMARY_VERSION += 1"
            fi
        else
            let "SECONDERY_VERSION += 1"
        fi
    else
        let "LOWER_VERSION += 1"
fi

NEW_APP_VERSION="$PRIMARY_VERSION.$SECONDERY_VERSION.$LOWER_VERSION"

NEW_APP_DETAILS="$NEW_APP_VERSION+$NEW_BUILD_NUMBER"

echo "Updating app version from $APP_DETAILS to $NEW_APP_DETAILS"

sed -i '' -e 's/'"$APP_DETAILS"'/'"$NEW_APP_DETAILS"'/g' "$FILE"