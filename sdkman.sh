#!/usr/bin/env bash

command -v sdk >/dev/null
if [ $? -eq 0 ]; then
    exit 0
fi

rpm -q zip >/dev/null
if [ $? -ne 0 ]; then
    sudo dnf -y install zip
fi

rpm -q unzip >/dev/null
if [ $? -ne 0 ]; then
    sudo dnf -y install unzip
fi

curl -s "https://get.sdkman.io" | bash

. ~/.profile
. "/home/$USER/.sdkman/bin/sdkman-init.sh"

SDKMAN_CONF_FILE_PATH=~/.sdkman/etc/config
if [ -e "${SDKMAN_CONF_FILE_PATH}" ]; then
    sed -i "s/^sdkman_auto_answer=.*/sdkman_auto_answer=true/" "${SDKMAN_CONF_FILE_PATH}"
    sed -i "s/^sdkman_auto_env=.*/sdkman_auto_env=true/" "${SDKMAN_CONF_FILE_PATH}"
fi
