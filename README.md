# Bluetooth Reset Service for Linux

A very simple, secure systemd service to fix Bluetooth initialization failures (race conditions) on system restart.
Also a simple example to teach about least priviledge custom systemd commands.

If you find this useful and would like to support its development, consider donating via:

- PayPal: https://www.paypal.com/paypalme/m1st0
- Venmo: https://venmo.com/code?user_id=3319592654995456106

© 2026 Maulik Mistry

This project is licensed under the Apache License 2.0. See the [LICENSE.txt](LICENSE.txt) file for details.

## The Problem

On some Ubuntu/Kubuntu variants, the Bluetooth driver (`btusb`) fails to initialize properly during a warm boot (restart). This often results in:
- Bluetooth appearing "On" but unable to find devices.
- No errors appearing in `journalctl -b` despite the hardware being unresponsive.

## Scripts

### bluetooth_reset.zsh
- Simple modprobe to reinitialize `btusb` module.
- Run from a root accessible secure location.

### bluetooth_reset_local.service
- A systemd service that runs the necessary script(s).

### install.zsh
- Place all needed files in secure root locations so `modprobe` and other commands can be run without risk.

Usage:
- `sudo ./install.zsh`
- Reboot or run `sudo systemctl start bluetooth_reset_local` which may require reconnecting Bluetooth devices on your favorite GUI like KDE Plasma.

### uninstall.zsh
- Remove specific installed files and undo systemctl setup.

Usage:
- `sudo ./uninstall.zsh`

## Requirements

- Ubuntu or other Debian-based Linux distro.
- Zsh shell for scripts or modify for Bash.
- sudo privileges for driver installation and module management.

## Security Note

This project follows the principle of least privilege. While the script runs with root authority to manage kernel modules, the installed files are owned by root:root with 755 permissions, ensuring they cannot be modified by a standard user.

## Troubleshooting

Check the status of the service at any time:

`systemctl status bluetooth_reset_local.service`

To view the logs from the last boot:

`journalctl -u bluetooth_reset_local.service`

