#!/usr/bin/env bash

SHELL_RC_FILE_PATH=$HOME/.bashrc

command -v nodenv >/dev/null
if [ $? -ne 0 ]; then
    curl -fsSL https://github.com/nodenv/nodenv-installer/raw/HEAD/bin/nodenv-installer | bash
fi

grep 'eval "$(nodenv init - bash)"' "${SHELL_RC_FILE_PATH}" >/dev/null
[ $? -ne 0 ] && tee -a "${SHELL_RC_FILE_PATH}" <<"EOF" >/dev/null

export NODENV_ROOT="$HOME/.nodenv"
command -v nodenv >/dev/null || export PATH="$NODENV_ROOT/bin:$PATH"
eval "$(nodenv init - bash)"
EOF

. "${SHELL_RC_FILE_PATH}"

NODE_BIN_PATH="$HOME/.nodenv/bin/nodenv"
NODE_LATEST_VERSION=$($NODE_BIN_PATH install --list | grep -E "^[0-9]" | tail -n 1)

$NODE_BIN_PATH install $NODE_LATEST_VERSION
$NODE_BIN_PATH global $NODE_LATEST_VERSION
