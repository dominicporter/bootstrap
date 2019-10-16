WORKSPACEPATH="ios/Runner.xcworkspace"
SCHEME="Runner"

xcodebuild build-for-testing -workspace $WORKSPACEPATH -scheme $SCHEME -destination generic/platform=iOS -derivedDataPath “build”
