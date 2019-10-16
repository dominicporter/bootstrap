
gcloud firebase test android run \
    --type robo \
    --app ./build/app/outputs/apk/app.apk \
    --device model=Nexus6,version=28,locale=en,orientation=portrait  \
    --device model=Nexus7,version=27,locale=en,orientation=portrait \
    --device model=Nexus7,version=26,locale=en,orientation=portrait \
    --timeout 90s