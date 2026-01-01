#!/bin/zsh
# Uninstallation script for bluetooth_reset project

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

print -P "%F{yellow}Removing bluetooth_reset service and files...%f"

# Stop and Disable the service
systemctl stop bluetooth_reset_local.service 2>/dev/null
systemctl disable bluetooth_reset_local.service 2>/dev/null

# Remove the files
rm /etc/systemd/system/bluetooth_reset_local.service
rm /usr/local/bin/bluetooth_reset.zsh

# Cleanup systemd state
systemctl daemon-reload
systemctl reset-failed

# Verification
if [[ ! -f /etc/systemd/system/bluetooth_reset_local.service && ! -f /usr/local/bin/bluetooth_reset.zsh ]]; then
    print -P "%F{green}Success: All files removed and systemctl state reset.%f"
else
    print -P "%F{red}Error: Some files could not be removed. Please check manually.%f"
    exit 1
fi
