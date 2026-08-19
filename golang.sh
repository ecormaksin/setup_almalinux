#!/usr/bin/env bash

GO_TARBALL_FILE_NAME=go1.26.4.linux-amd64.tar.gz
GO_TARBALL_URL=https://go.dev/dl/${GO_TARBALL_FILE_NAME}
GO_TARBALL_DST_DIR=/usr/local/src
GO_TARBALL_DST_FILE_PATH="${GO_TARBALL_DST_DIR}/${GO_TARBALL_FILE_NAME}"
ADD_GOLANG_BIN_FILE_PATH=/etc/add_path_golang_bin
SHELL_RC_FILE_PATH=$HOME/.bashrc

command -v go >/dev/null
if [ $? -eq 0 ]; then
    exit 0
fi

sudo mkdir -p "${GO_TARBALL_DST_DIR}"
cd "${GO_TARBALL_DST_DIR}" || exit 1
sudo wget --inet4-only --quiet "${GO_TARBALL_URL}"
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "${GO_TARBALL_DST_FILE_PATH}"

sudo tee "${ADD_GOLANG_BIN_FILE_PATH}" <<EOF >/dev/null
GOLANG_BIN_PATH=/usr/local/go/bin
echo \$PATH | grep \$GOLANG_BIN_PATH >/dev/null
if [ \$? -ne 0 ]; then
    export PATH=\$GOLANG_BIN_PATH:\$PATH
fi
EOF

if [ -e "${ADD_GOLANG_BIN_FILE_PATH}" ]; then

    grep ". ${ADD_GOLANG_BIN_FILE_PATH}" "${SHELL_RC_FILE_PATH}" >/dev/null
    if [ $? -ne 0 ]; then
        echo "" >> "${SHELL_RC_FILE_PATH}"
        echo ". ${ADD_GOLANG_BIN_FILE_PATH}" >> "${SHELL_RC_FILE_PATH}"
    fi
fi

. "${SHELL_RC_FILE_PATH}"
