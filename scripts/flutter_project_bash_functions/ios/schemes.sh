
echo "=== List of available, **shared** Schemes ==="
set -x
xcodebuild -workspace /Users/$HOME/dev/FlutterProjects/dial_in_v1/ios/Runner.xcworkspace -list
set +x
echo "============================================="