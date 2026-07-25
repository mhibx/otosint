#!/bin/bash

set -euo pipefail

source lib/utils.sh
source lib/enum.sh

readonly TARGET="${1:-}"

#######################################
# Validate input arguments.
#######################################
if [[ -z "$TARGET" ]]; then
    echo "Usage: ./recon.sh <target-domain>"
    exit 1
fi

#######################################
# Start reconnaissance workflow.
#######################################
log "[+] Starting reconnaissance for $TARGET"

check_dependencies

init_project "$TARGET"

run_enumeration "$TARGET"

clean_results "$TARGET"

#######################################
# Finished.
#######################################
log "[+] Reconnaissance completed."
log "[+] Raw results    : output/$TARGET/raw.txt"
log "[+] Unique results : output/$TARGET/unique.txt"
