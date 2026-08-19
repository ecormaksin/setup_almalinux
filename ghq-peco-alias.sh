#!/usr/bin/env bash

BASH_ALIASES_FILE_PATH=$HOME/.bash_aliases

[ ! -e "${BASH_ALIASES_FILE_PATH}" ] && touch "${BASH_ALIASES_FILE_PATH}"

cat "${BASH_ALIASES_FILE_PATH}" | grep -E "^alias gp='cd \\$\(ghq list --full-path \| peco\)'$" >/dev/null
if [ $? -eq 0 ]; then
    exit 0
fi

echo '' >> "${BASH_ALIASES_FILE_PATH}"
echo 'alias gp='\''cd $(ghq list --full-path | peco)'\' >> "${BASH_ALIASES_FILE_PATH}"
. "${BASH_ALIASES_FILE_PATH}"
