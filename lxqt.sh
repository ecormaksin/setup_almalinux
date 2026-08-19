#!/usr/bin/env bash

rpm -q lxqt >/dev/null
if [ $? -eq 0 ]; then
    exit 0
fi

sudo dnf -y groupinstall "LXQt Desktop"
