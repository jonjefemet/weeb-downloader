#!/usr/bin/env bash
# shellcheck source=/dev/null

source src/utils/throw_error.sh

check_if_valid_function() {
    local function=$1

    if [ "$(type -t "$function")" != "function" ]; then
        throw_error "Not a function."
    fi

}
