#!/usr/bin/env bash

rpm -q meld >/dev/null
if [ $? -ne 0 ]; then
    sudo dnf -y install meld
fi
