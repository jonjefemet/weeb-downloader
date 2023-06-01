#!/usr/bin/env bash

source src/utils/throw_error.sh


CFG_FILE=config.ini
declare -A CONFIG

function read_ini() {
    # Miramos la extensión extglob que nos permitirá utilizar
    # expresiones de sustitución complejas en Bash
    shopt -p extglob &>/dev/null
    local CHANGE_EXTGLOB=$?
    if [ $CHANGE_EXTGLOB = 1 ]; then
        # Establece la extensión
        shopt -s extglob
    fi

    local FILE="$1"

    if [ ! -e "$FILE" ]; then
        throw_error "The file $FILE. Does not exist" 1
    fi

    # Nombre por defecto cuando no hay sección
    local CURRENT_SECTION="_default"
    local ini="$(<$FILE)"

    # Quitamos los \r usados en la nueva línea en formato DOS
    ini=${ini//$'\r'/}
    # Convertimos a un array
    IFS=$'\n' && ini=(${ini})
    # Borra espacios al principio y al final (trim)
    ini=(${ini[*]/#+([[:space:]])/})
    ini=(${ini[*]/%+([[:space:]])/})
    # Borra comentarios, con ; y con #
    ini=(${ini[*]//;*/})
    ini=(${ini[*]//\#*/})

    for l in ${ini[*]}; do
        if [[ "$l" =~ ^\[(.*)\]$ ]]; then
            #echo "SECCION ${BASH_REMATCH[1]}"
            CURRENT_SECTION="${BASH_REMATCH[1]}"
        # Los comentarios los podemos quitar antes
        # elif [[ "$l" =~ ^\; || "$l" =~ ^\# ]]; then
        #       echo "COMENTARIO $l"
        elif [[ "$l" =~ ^(.*)=(.*)$ ]]; then
            local KEY="${CURRENT_SECTION}_"${BASH_REMATCH[1]%%+([[:space:]])}
            local VALUE=${BASH_REMATCH[2]##+([[:space:]])}

            CONFIG[$KEY]="$VALUE"
            # echo "EVALUA ""$KEY"" = ""$VALUE"""

        else
            throw_error "The format of $FILE. cannot be evaluated: $l" 1
        fi
    done

    if [ $CHANGE_EXTGLOB = 1 ]; then
        # Si tuvimos que meter la extensión, la quitamos
        shopt -u extglob
    fi
}
