#!/usr/bin/env bash

rpm -q curl >/dev/null
if [ $? -ne 0 ]; then
    sudo dnf -y install curl
fi
