#!/usr/bin/env bash

for PKG_NAME in docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
do
    rpm -q "${PKG_NAME}" >/dev/null
    if [ $? -ne 0 ]; then
        continue
    fi

    sudo dnf -y remove "${PKG_NAME}"
done

for PKG_NAME in ca-certificates curl gnupg
do
    rpm -q "${PKG_NAME}" >/dev/null
    if [ $? -eq 0 ]; then
        continue
    fi

    sudo dnf -y install "${PKG_NAME}"
done

sudo dnf -y install dnf-plugins-core

sudo tee /etc/yum.repos.d/docker-ce.repo <<EOF >/dev/null
[docker-ce]
name=Docker CE Stable
baseurl=https://download.docker.com/linux/centos/\$releasever/\$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/centos/gpg
EOF

sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable --now docker

if ! getent group docker | grep -q "$USER"; then
    sudo groupadd docker 2>/dev/null
    sudo usermod -aG docker "$USER"
fi

DOCKER_USER_DIR="${HOME}/.docker"

if [ -e "${DOCKER_USER_DIR}" ]; then
    sudo chown "$USER":"$USER" "${DOCKER_USER_DIR}" -R
    sudo chmod g+rwx "${DOCKER_USER_DIR}" -R
fi
