#!/usr/bin/env bash
# shellcheck source=/dev/null

source src/conf/styles.sh

throw_error() {

    local error_message="$1"
    local error_code="$2"

    if [ -z "$error_code" ]; then
        error_code=1
    fi

    echo -e "${STYLE_RED}${STYLE_UNDERLINED}Error${STYLE_RESET}: $error_message"
    exit "$error_code"
}
