#!/bin/zsh
# Reset bluetooth operation on Kubuntu 25.10.
# Author and Copyright (c) 2026 Maulik Mistry <mistry01@gmail.com>
# If you find this project useful and would like to support its development, consider donating via
# Paypal: https://www.paypal.com/paypalme/m1st0
# Venmo: https://venmo.com/code?user_id=3319592654995456106

# License: Apache License 2.0
# All rights reserved.

# Privilege check
if [[ $EUID -ne 0 ]]; then
   print -P "\n%F{red}Script must be run with proper privileges (sudo).%f\n"
   exit 1
fi

# Driver reset logic
modprobe -r btusb
sleep 0.5
modprobe btusb

print -P "%F{green}Bluetooth driver (btusb) has been reset successfully.%f"
