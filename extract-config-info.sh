if [ -z "$1" ]; then
  echo "Error: Area argument is missing."
  exit 1
fi

AREA=$1

FILE_PATH="$AREA.json"

echo "ok"
