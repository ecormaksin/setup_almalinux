#!/usr/bin/env bash

rpm -q xfce4-session >/dev/null
if [ $? -eq 0 ]; then
    exit 0
fi

sudo dnf -y groupinstall "Xfce Desktop"

sudo systemctl set-default graphical.target
