#!/usr/bin/env bash

command -v peco >/dev/null
if [ $? -eq 0 ]; then
    exit 0
fi

curl -L -o /tmp/peco_linux_amd64.tar.gz https://github.com/peco/peco/releases/download/v0.6.0/peco_0.6.0_linux_amd64.tar.gz

tar -xzf /tmp/peco_linux_amd64.tar.gz -C /tmp

sudo mv /tmp/peco /usr/local/bin/

rm -f /tmp/peco_linux_amd64.tar.gz /tmp/LICENSE /tmp/README.md /tmp/config.json
