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

DEV_ONLINE_ZONES=$(jq -c '.zonas.dev.online' "$FILE_PATH")
echo "zonas_online=$DEV_ONLINE_ZONES" >> "$GITHUB_OUTPUT"

DEV_BATCH_ZONES=$(jq -c '.zonas.dev.batch' "$FILE_PATH")
echo "zonas_batch=$DEV_BATCH_ZONES" >> "$GITHUB_OUTPUT"

FUNCIONALIDADES=$(jq -c '.funcionalidades' "$FILE_PATH")
echo "funcionalidades=$FUNCIONALIDADES" >> "$GITHUB_OUTPUT"

PROCESSOS_EXCECOES=$(jq -c '.processar_excecoes // []' "$FILE_PATH")
echo "excecoes=$PROCESSOS_EXCECOES" >> "$GITHUB_OUTPUT"
