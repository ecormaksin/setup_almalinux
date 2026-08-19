#!/usr/bin/env bash

linux_path=$(echo "$1" | sed -E 's/^([a-zA-Z]):/\/mnt\/\L\1/g' | sed -E 's/\\/\//g')

echo -n "$linux_path" | xclip -selection clipboard
echo "$linux_path"

# sudo ln -s <root_directory>/convert_windows_path_for_wsl.sh /usr/local/bin/cnv_path_wsl
