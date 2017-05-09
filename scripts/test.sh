#! /bin/sh

cd "$(dirname "$0")/.."

xcodebuild test -project JSONHelper.xcodeproj -scheme JSONHelper -destination 'platform=iOS Simulator,name=iPhone SE' -derivedDataPath='./build' | bundle exec xcpretty

IOS_STATUS=${PIPESTATUS[0]}

xcodebuild test -project JSONHelper.xcodeproj -scheme JSONHelper -destination 'platform=OS X,arch=x86_64' | bundle exec xcpretty

MAC_STATUS=${PIPESTATUS[0]}

xcodebuild test -project JSONHelper.xcodeproj -scheme JSONHelper -destination 'platform=tvOS Simulator,name=Apple TV 1080p' | bundle exec xcpretty

TVOS_STATUS=${PIPESTATUS[0]}

if [[ $IOS_STATUS == 0 && $MAC_STATUS == 0 && $TVOS_STATUS == 0 ]]; then
  echo "All tests have passed."
  exit 0
else
  echo "Some tests have failed."
  exit 1
fi
