# AlmaLinux シェルの初期設定

## _main.sh実行前の手動手順

- `LANG=C xdg-user-dirs-update --force` を実行してホームディレクトリのフォルダ名を日本語から英語へ変更する。

- gitをインストールする。

  ```shell
  sudo dnf -y install git
  ```

  ```shell
  git config --global user.name "<name>"
  git config --global user.email <email>
  ```

- `./_setup_ssh_conf.sh` を実行してssh用の設定フォルダーと基底ファイルを作成する

- `~/.ssh` へprivate鍵を配置し、`chmod 600 ~/.ssh/<private_key_file_name>` を実行する。

- `~/.ssh` へpublic鍵を配置し、`chmod 600 ~/.ssh/<public_key_file_name>` を実行する。

- `keychain` を使ってSSH接続のprivate鍵をログイン時に読み込ませる。
  （private鍵のアルゴリズムは `ed25519`、ファイル パスは `~/.ssh/id_ed25519` の想定）

  ```shell
  sudo dnf -y install keychain

  EXPORT_COMMAND='eval `keychain --eval --agents ssh id_ed25519`'
  echo ~/.profile | grep "${EXPORT_COMMAND}" >/dev/null
  GREP_RESULT=$?
  [ $GREP_RESULT -ne 0 ] && echo -e "\n${EXPORT_COMMAND}" >> ~/.profile
  . ~/.profile
  ```

  ログイン時にパスフレーズ入力待ちでVagrantの仮想マシン上等问题がある場合は、エイリアスを登録して手動で入力するなどで対応する。

  ```shell
  mkdir -p ~/.bashrc.d
  [ -f ~/.bashrc.d/keychain ] && grep keychain ~/.bashrc.d/keychain >/dev/null || echo "alias start-keychain='eval \`keychain --eval --agents ssh id_ed25519\`'" >> ~/.bashrc.d/keychain
  ```
