#!/usr/bin/env bash

TARGET_LOCALE=ja_JP.UTF-8

rpm -q glibc-langpack-ja >/dev/null
if [ $? -ne 0 ]; then
    sudo dnf -y install glibc-langpack-ja
fi

localectl status | grep "${TARGET_LOCALE}" >/dev/null
if [ $? -ne 0 ]; then
    sudo localectl set-locale LANG="${TARGET_LOCALE}"
    . /etc/locale.conf
fi
