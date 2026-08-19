#!/usr/bin/env bash

rpm -q podman >/dev/null
if [ $? -ne 0 ]; then
    sudo dnf -y install podman
fi

pip3 list 2>/dev/null | grep podman-compose >/dev/null
if [ $? -ne 0 ]; then
    pip3 install --user podman-compose
fi
