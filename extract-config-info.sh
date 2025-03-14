if [ -z "$1" ]; then
  echo "Error: Area argument is missing."
  exit 1
fi

AREA=$1

FILE_PATH="$AREA.json"

if [ ! -f "$FILE_PATH" ]; then
  echo "Error: File '$FILE_PATH' not found."
  exit 1
fi

AREA_FROM_FILE=$(jq -r '.area' "$FILE_PATH")

echo "area=$AREA_FROM_FILE" >> "$GITHUB_OUTPUT"
