#!/usr/bin/env bash

source src/utils/read_ini.sh
source src/conf/styles.sh

read_ini "$CFG_FILE"

echo "Servidor principal: "${CONFIG["mangaplus_url"]}