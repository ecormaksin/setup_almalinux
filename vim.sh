#!/usr/bin/env bash

BASH_RC_D_DIR=$HOME/.bashrc.d
BASH_RC_D_FILE_PATH=${BASH_RC_D_DIR}/vim
VIM_ALIAS_STRING="alias vi='vim'"

sudo curl --output /etc/vimrc.local --silent https://raw.githubusercontent.com/ecormaksin/vimrc/main/vimrc

mkdir -p "${BASH_RC_D_DIR}"

if [ -f "${BASH_RC_D_FILE_PATH}" ]; then
    grep "${VIM_ALIAS_STRING}" "${BASH_RC_D_FILE_PATH}" >/dev/null
    if [ $? -ne 0 ]; then
        echo "" >> "${BASH_RC_D_FILE_PATH}"
        echo "${VIM_ALIAS_STRING}" >> "${BASH_RC_D_FILE_PATH}"
    fi
else
    echo "${VIM_ALIAS_STRING}" >> "${BASH_RC_D_FILE_PATH}"
fi
. "${BASH_RC_D_FILE_PATH}"

rpm -q vim-enhanced >/dev/null
if [ $? -ne 0 ]; then
    sudo dnf -y install vim-enhanced
fi
