#!/usr/bin/env bash

REPO="https://api.github.com/repos/apisquared/a2ctl/releases"
DOWNLOAD_URL="https://github.com/apisquared/a2ctl/releases/download"

CLI_VERSION=""
get_latest_release() {
  echo "$(curl --silent "$REPO/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')"
}
get_stripped_release() {
  echo "$(echo $CLI_VERSION | cut -c 2-)"
}

echo "Getting latest Apisquared CLI..."
CLI_VERSION=$(get_latest_release)
echo " - Latest CLI version "$CLI_VERSION"..."

OS=""
get_os() {
  if [ $(uname) == "Darwin" ]; then
    OS=darwin
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    OS=linux
  else
    echo "This installer is only supported on Linux and MacOS. Found "$(uname)
    exit 1
  fi
}
get_os

ARCH=$(uname -m)
get_arch() {
  if [ $ARCH == "x86_64" ]; then
    ARCH=64
  elif [[ $ARCH == "arm64" ]]; then
    ARCH=arm64
  elif [[ $ARCH == "amd64" ]]; then
    ARCH=amd64
  else
    echo "Unsupported arch: "$ARCH
    exit 1
  fi
} 
get_arch

FILE="a2ctl-"$(get_stripped_release)"-"$OS"-"$ARCH".tar.gz"
SHA_FILE="a2ctl-"$(get_stripped_release)"-"$OS"-"$ARCH".sha256"
BIN_URL=$DOWNLOAD_URL"/"$CLI_VERSION"/"$FILE
SHA_FILE_URL=$DOWNLOAD_URL"/"$CLI_VERSION"/"$SHA_FILE
CTL="a2ctl"
echo "Downloading "$BIN_URL
get_compressed() {
  $(curl -LO -H 'Cache-Control: no-cache, no-store' -H 'Pragma: no-cache' --silent $BIN_URL)
}

$(curl -LO -H 'Cache-Control: no-cache, no-store' -H 'Pragma: no-cache' --silent $BIN_URL)
$(curl -LO -H 'Cache-Control: no-cache, no-store' -H 'Pragma: no-cache' --silent $SHA_FILE_URL)
if ! echo "$(cat $SHA_FILE)" | shasum -a 256 --check; then
  echo "Failed to validate file"
  exit 1
fi
if ! tar -xzvf $FILE; then
  echo "Failed to download from repository"
  exit 1
fi
rm $FILE
rm $SHA_FILE  

echo " - Installed"
chmod +x "./"$CTL
echo " - Done"
