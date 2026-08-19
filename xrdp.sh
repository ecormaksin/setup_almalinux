#!/usr/bin/env bash

sudo dnf -y install epel-release

rpm -q xrdp >/dev/null
if [ $? -ne 0 ]; then
    sudo dnf -y install xrdp
fi

sudo systemctl enable --now xrdp
sudo firewall-cmd --permanent --add-port=3389/tcp
sudo firewall-cmd --reload

echo 'You need to configure ~/.xsession or ~/.Xclients.'

# echo "xfce4-session" | tee ~/.xsession
# echo "startlxqt" | tee ~/.xsession
