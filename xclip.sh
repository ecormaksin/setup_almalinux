#!/usr/bin/env bash

rpm -q xclip >/dev/null
if [ $? -ne 0 ]; then
    sudo dnf -y install xclip
fi

BASH_RC_D_DIR=$HOME/.bashrc.d
BASH_RC_D_FILE_PATH=${BASH_RC_D_DIR}/xclip

mkdir -p "${BASH_RC_D_DIR}"

for ALIAS_STRING in "alias pbcopy='xclip -selection c'" "alias pbpaste='xclip -selection c -o'"
do
    if [ -f "${BASH_RC_D_FILE_PATH}" ]; then
        grep "${ALIAS_STRING}" "${BASH_RC_D_FILE_PATH}" >/dev/null
        if [ $? -ne 0 ]; then
            echo "" >> "${BASH_RC_D_FILE_PATH}"
            echo "${ALIAS_STRING}" >> "${BASH_RC_D_FILE_PATH}"
        fi
    else
        echo "${ALIAS_STRING}" >> "${BASH_RC_D_FILE_PATH}"
    fi
done

. "${BASH_RC_D_FILE_PATH}"
