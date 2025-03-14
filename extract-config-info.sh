#!/bin/bash

AREA=$1

echo "$AREA"

FILE_PATH="$AREA.json"

if [ ! -f "$FILE_PATH" ]; then
  echo "File not found!"
  exit 1
fi

AREA=$(jq -r '.area' "$FILE_PATH")
echo "area=$AREA" >> $GITHUB_OUTPUT
