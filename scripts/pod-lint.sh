#! /bin/sh

cd "$(dirname "$0")/.."

bundle exec pod spec lint JSONHelper.podspec --allow-warnings
