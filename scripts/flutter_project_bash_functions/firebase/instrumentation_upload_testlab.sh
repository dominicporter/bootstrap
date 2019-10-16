
gcloud firebase test android run \
    --type instrumentation \
    --app ./build/app/outputs/apk/app.apk \
    --test app-debug-test-unaligned.apk \
    --device model=Nexus6,version=26,locale=en,orientation=portrait  \
    --device model=Nexus6,version=25,locale=en,orientation=portrait  \
    --device model=Nexus6,version=24,locale=en,orientation=portrait  \
    --device model=Nexus6,version=23,locale=en,orientation=portrait  \
    --device model=Nexus6,version=22,locale=en,orientation=portrait  \
