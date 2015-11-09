#!/bin/bash
source $cmdpath/options.sh

if [ $use_adb ]; then
    sudo adb root
    sudo adb remount
    sudo adb push out/target/product/$product/recovery.img /data/local/ # FIXME: last out dir in releases/
    sudo adb shell dd if=/data/local/recovery.img of=$settings_default_recovery_block
    sudo adb shell rm /data/local/recovery.img
else
    # TODO FIXME
    show_error "Not implemented."
fi
