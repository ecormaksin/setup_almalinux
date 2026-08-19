#!/usr/bin/env bash

SYSCTL_CONF_FILE=/etc/sysctl.d/60-ipv6-disable.conf

[ ! -e "${SYSCTL_CONF_FILE}" ] && sudo tee "${SYSCTL_CONF_FILE}" <<"EOF" >/dev/null
net.ipv6.conf.all.disable_ipv6=1
net.ipv6.conf.default.disable_ipv6=1
net.ipv6.conf.lo.disable_ipv6=1
EOF

sudo sysctl -p "${SYSCTL_CONF_FILE}"
