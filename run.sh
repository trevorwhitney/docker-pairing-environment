#!/usr/bin/env bash

set -euo pipefail

set -x

# reinstall openssh if no config provided
test -e /etc/ssh/sshd_config || { dpkg --purge openssh-server; apt-get install -y openssh-server; }

exec /lib/systemd/systemd
