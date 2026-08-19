#!/usr/bin/env bash

sudo dnf -y install epel-release

rpm -q fcitx5 >/dev/null
if [ $? -ne 0 ]; then
    sudo dnf -y install fcitx5 fcitx5-mozc fcitx5-configtool fcitx5-gtk(fcitx5-gtk2 fcitx5-gtk3) \
fcitx5-qt(fcitx5-qt5 fcitx5-qt6) fcitx5-input-method-addons fcitx5-chinese-addons fcitx5-kcm
fi

im-config -n fcitx5
