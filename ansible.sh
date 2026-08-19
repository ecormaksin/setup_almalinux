#!/usr/bin/env bash

python -m pip list 2>/dev/null | grep ansible >/dev/null
if [ $? -eq 0 ]; then
    python -m pip -q install --upgrade --user ansible
else
    python -m pip -q install --user ansible
fi

. ~/.profile
