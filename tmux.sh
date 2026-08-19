#!/usr/bin/env bash

rpm -q tmux >/dev/null
if [ $? -ne 0 ]; then
    sudo dnf -y install tmux
fi

curl --output ~/.tmux.conf --silent https://raw.githubusercontent.com/ecormaksin/tmux_conf/main/.tmux.conf
