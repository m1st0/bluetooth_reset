#!/bin/zsh
# Installation script for bluetooth_reset project

# Author and Copyright (c) 2026 Maulik Mistry <mistry01@gmail.com>
# If you find this project useful and would like to support its development, consider donating via
# Paypal: https://www.paypal.com/paypalme/m1st0
# Venmo: https://venmo.com/code?user_id=3319592654995456106

# License: Apache License 2.0
# All rights reserved.

if [[ $EUID -ne 0 ]]; then
   print -P "%F{red}Please run installer with sudo.%f"
   exit 1
fi

print -P "%F{blue}Deploying bluetooth_reset files...%f"

# Copying to system paths
cp ./bluetooth_reset.zsh /usr/local/bin/bluetooth_reset.zsh
cp ./bluetooth_reset_local.service /etc/systemd/system/bluetooth_reset_local.service

# Securing permissions
chown root:root /usr/local/bin/bluetooth_reset.zsh /etc/systemd/system/bluetooth_reset_local.service
chmod 755 /usr/local/bin/bluetooth_reset.zsh
chmod 644 /etc/systemd/system/bluetooth_reset_local.service

# Reload and Enable
systemctl daemon-reload
systemctl enable bluetooth_reset_local.service

print -P "%F{green}Installation complete. The service will run on next boot.%f"
