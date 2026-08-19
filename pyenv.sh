#!/usr/bin/env bash

command -v pyenv >/dev/null
if [ $? -eq 0 ]; then
    exit 0
fi

curl -sfL https://pyenv.run | bash

for FILE_PATH in "${HOME}/.bashrc" "${HOME}/.profile" "${HOME}/.bash_profile" "${HOME}/.bash_login"
do
    if [ ! -e "${FILE_PATH}" ]; then
        continue
    fi

    echo ''
    echo "${FILE_PATH}"
    echo ''

    grep 'PYENV_ROOT' "${FILE_PATH}" >/dev/null
    GREP_RESULT=$?
    if [ $GREP_RESULT -eq 0 ]; then
        continue
    fi

    echo '' >> "${FILE_PATH}"
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> "${FILE_PATH}"
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> "${FILE_PATH}"
    echo 'eval "$(pyenv init -)"' >> "${FILE_PATH}"
    . "${FILE_PATH}"

done

sudo dnf -y groupinstall "Development Tools"
sudo dnf -y install openssl-devel bzip2-devel libffi-devel readline-devel sqlite-devel \
xz-devel tk-devel zlib-devel wget curl

. ~/.profile
