#!/usr/bin/env bash

BASH_PROFILE_FILE_PATH=$HOME/.bash_profile

[ ! -e "${BASH_PROFILE_FILE_PATH}" ] && touch "${BASH_PROFILE_FILE_PATH}"

for EXPORT_COMMAND in '. ~/.profile' '. ~/.bashrc'
do
    grep "${EXPORT_COMMAND}" "${BASH_PROFILE_FILE_PATH}" >/dev/null
    GREP_RESULT=$?
    [ $GREP_RESULT -ne 0 ] && echo "${EXPORT_COMMAND}" >> "${BASH_PROFILE_FILE_PATH}"
done
