#!/usr/bin/env bash

rpm -q powershell >/dev/null
if [ $? -eq 0 ]; then
    exit 0
fi

sudo rpm -Uvh https://github.com/PowerShell/PowerShell/releases/download/v7.4.6/powershell-7.4.6-1.rhel.8.x86_64.rpm
