if [ -z "$1" ]; then
  echo "Error: Area argument is missing."
  exit 1
fi

if [ -z "$2" ]; then
  echo "Error: Trabalho argument is missing."
  exit 1
fi

AREA=$1
TRABALHO=$2

FILE_PATH="$AREA.json"

if [ ! -f "$FILE_PATH" ]; then
  echo "Error: File '$FILE_PATH' not found."
  exit 1
fi

AREA_FROM_FILE=$(jq -r '.area' "$FILE_PATH")
echo "area=$AREA_FROM_FILE" >> "$GITHUB_OUTPUT"

DEV_ONLINE_ZONES=$(jq -c '.zonas.dev.online' "$FILE_PATH")
echo "zonas_online=$DEV_ONLINE_ZONES" >> "$GITHUB_OUTPUT"

DEV_BATCH_ZONES=$(jq -c '.zonas.dev.batch' "$FILE_PATH")
echo "zonas_batch=$DEV_BATCH_ZONES" >> "$GITHUB_OUTPUT"

FUNCIONALIDADES=$(jq -c '.funcionalidades' "$FILE_PATH")
echo "funcionalidades=$FUNCIONALIDADES" >> "$GITHUB_OUTPUT"

EXCEPTION_EXISTS=$(jq --arg job "$TRABALHO" '.["process-exceptions"][] | select(.trabalho == $job)' "$JSON_FILE")

if [ -z "$EXCEPTION_EXISTS" ]; then
  echo "Job $JOB_TO_CHECK is not in exceptions. Skipping."
  echo "skip_job=true" >> $GITHUB_ENV
else
  echo "Job $JOB_TO_CHECK is in exceptions. Proceeding."
  # Extrai as zonas online ou batch
  ONLINE_ZONES=$(echo "$EXCEPTION_EXISTS" | jq -r '.zonas.dev.online | @csv')
  BATCH_ZONES=$(echo "$EXCEPTION_EXISTS" | jq -r '.zonas.dev.batch | @csv')
  echo "online_zones=$ONLINE_ZONES" >> $GITHUB_ENV
  echo "batch_zones=$BATCH_ZONES" >> $GITHUB_ENV
  echo "skip_job=false" >> $GITHUB_ENV
fi
