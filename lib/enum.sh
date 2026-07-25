#!/bin/bash

set -euo pipefail

#######################################
# Run passive subdomain enumeration.
#######################################
run_enumeration() {

    local target="$1"
    local output_dir="output/$target"
    local raw_file="$output_dir/raw.txt"

    ###################################
    # Subfinder
    ###################################

    log "[*] Running Subfinder..."

    subfinder \
        -d "$target" \
        -silent \
        >> "$raw_file" \
        2>/dev/null

    ###################################
    # Assetfinder
    ###################################

    log "[*] Running Assetfinder..."

    assetfinder \
        --subs-only "$target" \
        >> "$raw_file" \
        2>/dev/null

    ###################################
    # crt.sh
    ###################################

    log "[*] Querying crt.sh..."

    local response

    response=$(
        curl \
            --connect-timeout 10 \
            --max-time 30 \
            -s \
            "https://crt.sh/?q=%25.$target&output=json"
    )

    if [[ -n "$response" ]]; then

        echo "$response" \
            | jq -r '.[].name_value' 2>/dev/null \
            | tr '\r' '\n' \
            | sed 's/\*\.//' \
            >> "$raw_file"

        log "[+] crt.sh completed."

    else

        log "[!] crt.sh returned an empty response."

    fi

}
