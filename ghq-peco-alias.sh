#!/usr/bin/env bash

BASH_RC_D_DIR=$HOME/.bashrc.d
BASH_RC_D_FILE_PATH=${BASH_RC_D_DIR}/gp

mkdir -p "${BASH_RC_D_DIR}"

if [ -f "${BASH_RC_D_FILE_PATH}" ]; then
    grep -E "^alias gp='cd \\$\(ghq list --full-path \| peco\)'$" "${BASH_RC_D_FILE_PATH}" >/dev/null
    if [ $? -eq 0 ]; then
        exit 0
    fi
fi

echo '' >> "${BASH_RC_D_FILE_PATH}"
echo 'alias gp='\''cd $(ghq list --full-path | peco)'\' >> "${BASH_RC_D_FILE_PATH}"
. "${BASH_RC_D_FILE_PATH}"
