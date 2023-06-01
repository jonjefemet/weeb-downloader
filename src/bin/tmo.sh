#!/usr/bin/env bash

#!/usr/bin/env bash

source src/utils/read_ini.sh
source src/conf/styles.sh

read_ini "$CFG_FILE"

echo "Principal server: "${CONFIG["tmo_url"]}

read -p "Search title: " title

contenido=$(wget --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3" ${CONFIG["tmo_url"]}"library?_pg=1&title=${title/ /+}")

mapfile -t titles < <(echo $contenido | grep -oP "(?<=<h4 class=\"text-truncate\" title=\").*?(?=\">)")


echo $contenido
