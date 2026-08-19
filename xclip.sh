#!/usr/bin/env bash

rpm -q xclip >/dev/null
if [ $? -ne 0 ]; then
    sudo dnf -y install xclip
fi

BASH_ALIASES_FILE_PATH=$HOME/.bash_aliases
[ ! -e "${BASH_ALIASES_FILE_PATH}" ] && touch "${BASH_ALIASES_FILE_PATH}"

for ALIAS_STRING in "alias pbcopy='xclip -selection c'" "alias pbpaste='xclip -selection c -o'"
do
    grep "${ALIAS_STRING}" "${BASH_ALIASES_FILE_PATH}" >/dev/null
    if [ $? -ne 0 ]; then
        echo "" >> "${BASH_ALIASES_FILE_PATH}"
        echo "${ALIAS_STRING}" >> "${BASH_ALIASES_FILE_PATH}"
    fi
done

. "${BASH_ALIASES_FILE_PATH}"
