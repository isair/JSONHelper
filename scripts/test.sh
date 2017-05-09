#! /bin/sh

cd "$(dirname "$0")/.."

xcodebuild test -project JSONHelper.xcodeproj -scheme JSONHelper-iOS -destination 'platform=iOS Simulator,name=iPhone SE' -derivedDataPath='./build' | bundle exec xcpretty

IOS_STATUS=${PIPESTATUS[0]}

xcodebuild test -project JSONHelper.xcodeproj -scheme JSONHelper-Mac -destination 'platform=OS X,arch=x86_64' | bundle exec xcpretty

MAC_STATUS=${PIPESTATUS[0]}

exit $IOS_STATUS || $MAC_STATUS
