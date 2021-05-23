#!/bin/bash

#
# TODO:
#   version variable control
#   interactive interface
#

download_recovery()
{
    wget -O twrp.img https://jaist.dl.sourceforge.net/project/mbroms/TWRPLMI/MBTWRP_21-05-2021_LMI.img

    adb kill-server
    adb reboot bootloader
    fastboot flash reovery twrp.img
    fastboot boot twrp.img
}

download_eurom()
{
    wget https://jaist.dl.sourceforge.net/project/xiaomi-eu-multilang-miui-roms/xiaomi.eu/MIUI-WEEKLY-RELEASES/21.5.20/xiaomi.eu_multi_HMK30Pro_21.5.20_v12-11.zip
}

download_lineage()
{
    wget https://files.sebaubuntu.dev/ROMs/lmi/LineageOS/11/lineage-18.1-20210429-UNOFFICIAL-lmi.zip
}

main()
{
    download_recovery
    #download_eurom
    #download_lineage
}

main
