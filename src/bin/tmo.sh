#!/usr/bin/env bash
# shellcheck source=/dev/null

source src/utils/read_ini.sh
source src/conf/styles.sh
source src/utils/menu.sh


read_ini "$CFG_FILE"

echo "Principal server: ${CONFIG["tmo_url"]}"

read -rp "Search title: " title

filter="${CONFIG["tmo_url"]}library?_pg=1&title=${title/ /+}"

contenido=$(wget -qO- --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3" "$filter" )

mapfile -t titles < <(echo "$contenido" | grep -oP "(?<=<h4 class=\"text-truncate\" title=\").*?(?=\">)")

for element in "${titles[@]}"; do
    echo "$element"
done