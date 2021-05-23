# HackRedmiK30Pro

Redmi K30 Pro(lmi) hacking.

## Getting Started

> [Latest firmware](https://xiaomifirmwareupdater.com/firmware/lmi/) requested.

### Unlock

If you have no active mi account, please wait at least 168 hours and then use miflash_unlock tool to unlock the phone.

Follows unlock instruction in [this page](https://en.miui.com/unlock/).

### Flash TWRP

Run script `./install.sh` to download and flash recovery.

### Flash ROM

Follows [XDA links](https://forum.xda-developers.com/f/xiaomi-poco-f2-pro-redmi-k30-pro-roms-kernels.10683/).

Also you can choose official ROM builds like [xiaomi.eu](https://xiaomi.eu).

~~Use command `python3 download.py` to download given ROM to your path.~~

Recommend LineageOS 18.1/xiaomi.eu ROM/PE series.

Fastboot flash zip: [https://xiaomirom.com/rom/redmi-k30-pro-poco-f2-pro-lmi-china-fastboot-recovery-rom/](https://xiaomirom.com/rom/redmi-k30-pro-poco-f2-pro-lmi-china-fastboot-recovery-rom/).

## Issues

Decryption issue pleas flash no_replace_twrp_avb2.zip in recovery mode and flash vbmeta.img in fastboot mode.

## Credit

- Xiaomi.com
- wzsx150
- etc.
