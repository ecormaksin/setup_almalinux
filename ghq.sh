#!/usr/bin/env bash

ADD_GOLANG_PKG_FILE_PATH=/etc/add_path_golang_pkg
SHELL_RC_FILE_PATH=$HOME/.bashrc

command -v ghq >/dev/null
if [ $? -eq 0 ]; then
    exit 0
fi

/usr/local/go/bin/go install github.com/x-motemen/ghq@latest

sudo tee "${ADD_GOLANG_PKG_FILE_PATH}" <<EOF >/dev/null
GOLANG_PKG_PATH=\$HOME/go/bin
echo \$PATH | grep \$GOLANG_PKG_PATH >/dev/null
if [ \$? -ne 0 ]; then
    export PATH=\$GOLANG_PKG_PATH:\$PATH
fi
EOF

if [ -e "${ADD_GOLANG_PKG_FILE_PATH}" ]; then

    grep ". ${ADD_GOLANG_PKG_FILE_PATH}" "${SHELL_RC_FILE_PATH}" >/dev/null
    if [ $? -ne 0 ]; then
        echo ". ${ADD_GOLANG_PKG_FILE_PATH}" >> "${SHELL_RC_FILE_PATH}"
    fi
fi

. "${SHELL_RC_FILE_PATH}"

mkdir -p ~/ws/ghq
git config --global ghq.root "${HOME}/ws/ghq"
