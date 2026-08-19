#!/usr/bin/env bash

FILE_PATH=/etc/customize_shell_ps
CHECK_EXPORT_PS1_STR="export PS1="
SHELL_RC_FILE_PATH=$HOME/.bashrc
EXPORT_USER_STRING="export PS1=\"\["'\\e'"[1;32m\]\u@\h \["'\\e'"[36m\]\D{%y/%m/%d %H:%M:%S}\["'\\e'"[0m\]\$PS1_GIT_BRANCH \w"'\\n'"\\$ \""
SHELL_RC_ROOT_USER_FILE_PATH=/root/.bashrc
EXPORT_ROOT_USER_STRING="export PS1=\"\["'\\e'"[1;31m\]\u@\h \["'\\e'"[36m\]\D{%y/%m/%d %H:%M:%S}\["'\\e'"[0m\]\$PS1_GIT_BRANCH \w"'\\n'"# \""

sudo tee "${FILE_PATH}" <<EOF >/dev/null
function ps1_ls() {
    [[ \$_PWD == \$PWD ]] || { _PWD=\$PWD; ls; }
}

function ps1_newline() {
    if [[ -z "\${PS1_NEWLINE_LOGIN}" ]]; then
        PS1_NEWLINE_LOGIN=true
    else
        printf '\n'
    fi
}

function ps1_customize() {
    # ps1_ls
    ps1_newline
}

function ps1_git_branch() {
    git symbolic-ref HEAD 2>/dev/null >/dev/null &&
    echo "(\$(git symbolic-ref HEAD 2>/dev/null | sed 's/^refs\/heads\///'))"
}

PROMPT_COMMAND=ps1_customize

if [ -n "\$ps1_git_branch" ]; then
    PS1_GIT_BRANCH='\[\e[1;33m\]\$(ps1_git_branch "(%s)")\[\e[0m\]'
else
    PS1_GIT_BRANCH=
fi
EOF

if [ -e "${FILE_PATH}" ]; then

    # 一般ユーザー
    grep ". ${FILE_PATH}" "${SHELL_RC_FILE_PATH}" >/dev/null
    if [ $? -ne 0 ]; then
        echo "" >> "${SHELL_RC_FILE_PATH}"
        echo ". ${FILE_PATH}" >> "${SHELL_RC_FILE_PATH}"
    fi

    grep "${CHECK_EXPORT_PS1_STR}" "${SHELL_RC_FILE_PATH}" >/dev/null
    if [ $? -ne 0 ]; then
        echo "${EXPORT_USER_STRING}" >> "${SHELL_RC_FILE_PATH}"
    fi

    # rootユーザー
    sudo grep ". ${FILE_PATH}" "${SHELL_RC_ROOT_USER_FILE_PATH}" >/dev/null
    if [ $? -ne 0 ]; then
        echo "" | sudo tee -a "${SHELL_RC_ROOT_USER_FILE_PATH}" >/dev/null
        echo ". ${FILE_PATH}" | sudo tee -a "${SHELL_RC_ROOT_USER_FILE_PATH}" >/dev/null
    fi

    sudo grep "${CHECK_EXPORT_PS1_STR}" "${SHELL_RC_ROOT_USER_FILE_PATH}" >/dev/null
    if [ $? -ne 0 ]; then
        echo "${EXPORT_ROOT_USER_STRING}" | sudo tee -a "${SHELL_RC_ROOT_USER_FILE_PATH}" >/dev/null
    fi
fi

. "${SHELL_RC_FILE_PATH}"
