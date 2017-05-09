#! /bin/sh

# Check project requirements

check_required_bin() {
  if ! hash $1 2>/dev/null; then
    echo "$1 not found."
    exit 1
  fi
}

check_requirements() {
  check_required_bin rbenv
  check_required_bin bundle
  check_required_bin xcodebuild
}

printf "Checking project requirements... "
check_requirements
echo "done."

# Initialize project

cd "$(dirname "$0")/.."

bundle install --path vendor/bundle
