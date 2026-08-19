#!/usr/bin/env bash

SSH_DIR_PATH=$HOME/.ssh

[ ! -d "${SSH_DIR_PATH}" ] && mkdir "${SSH_DIR_PATH}" && chmod 700 "${SSH_DIR_PATH}"

tee "${SSH_DIR_PATH}/config" <<EOF >/dev/null
Include ~/.ssh/config.d/*
Include ~/.ssh/./*/config

Host *
    ServerAliveInterval 15
    ServerAliveCountMax 3
    AddKeysToAgent yes
    IdentitiesOnly yes
EOF

chmod 600 "${SSH_DIR_PATH}/config"
