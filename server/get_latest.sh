#!/bin/sh
RELEASE=$(curl --silent "https://api.github.com/repos/EpicCash/epic/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"([^"]+)".*/\1/')
LATEST="${RELEASE:1}"
echo "https://github.com/EpicCash/epic/releases/download/"$RELEASE"/epic_"$LATEST"_amd64.deb"