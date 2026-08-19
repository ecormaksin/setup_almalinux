#!/usr/bin/env bash

rpm -q openssh-server >/dev/null
if [ $? -ne 0 ]; then
    sudo dnf -y install openssh-server
fi

sudo sed -i "s/^#\?PermitRootLogin .*/PermitRootLogin no/" /etc/ssh/sshd_config

# sudo sed -i "s/^#PasswordAuthentication .*/PasswordAuthentication no/" /etc/ssh/sshd_config
