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

EXCEPTION_EXISTS=$(jq --arg job "$TRABALHO" '.["processar_excecoes"][] | select(.trabalho == $job)' "$FILE_PATH")

if [ -z "$EXCEPTION_EXISTS" ]; then

  echo "e_excecao=false" >> "$GITHUB_OUTPUT"
  
else

  echo "e_excecao=true" >> "$GITHUB_OUTPUT"

  EXCEPTION_DEV_ONLINE_ZONES=$(echo "$EXCEPTION_EXISTS" | jq -c '.zonas.dev.online')
  echo "zonas_online_excecao=$DEV_ONLINE_ZONES" >> "$GITHUB_OUTPUT"
  
  EXCEPTION_DEV_BATCH_ZONES=$(echo "$EXCEPTION_EXISTS" | jq -c '.zonas.dev.batch')
  echo "zonas_batch_excecao=$DEV_BATCH_ZONES" >> "$GITHUB_OUTPUT"

fi
