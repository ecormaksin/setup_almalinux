#!/usr/bin/env bash

command -v nix >/dev/null
if [ $? -ne 0 ]; then
    curl -L https://nixos.org/nix/install | sh -s -- --daemon
fi

rpm -q direnv >/dev/null
if [ $? -ne 0 ]; then
    sudo dnf -y install direnv
fi

grep "direnv hook bash" ~/.bashrc >/dev/null
[ $? -ne 0 ] && tee -a ~/.bashrc <<"EOF" >/dev/null

eval "$(direnv hook bash)"
export DIRENV_LOG_FORMAT=
EOF
