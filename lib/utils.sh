#!/bin/bash

set -euo pipefail

#######################################
# Print a timestamped log message.
#######################################
log() {
    echo "[$(date '+%H:%M:%S')] $1"
}

#######################################
# Verify required tools are installed.
#######################################
check_dependencies() {

    local tools=(
        subfinder
        assetfinder
        curl
        jq
    )

    log "[*] Checking dependencies..."

    for tool in "${tools[@]}"; do

        if command -v "$tool" >/dev/null 2>&1; then
            log "[+] $tool found"
        else
            log "[!] Missing dependency: $tool"
            exit 1
        fi

    done

}

#######################################
# Initialize project directory.
#######################################
init_project() {

    local target="$1"
    local output_dir="output/$target"

    mkdir -p "$output_dir"
    mkdir -p logs

    : > "$output_dir/raw.txt"

}

#######################################
# Normalize and deduplicate results.
#######################################
clean_results() {

    local target="$1"
    local output_dir="output/$target"

    local raw_file="$output_dir/raw.txt"
    local unique_file="$output_dir/unique.txt"

    sed 's|http://||' "$raw_file" \
    | sed 's|https://||' \
    | sed 's|/.*||' \
    | sed 's/\*\.//' \
    | grep "$target" \
    | sort -u \
    > "$unique_file"

}
