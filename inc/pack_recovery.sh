#!/bin/bash

# pack recovery?
###########################################
if [ $recovery ] && [ -f out/target/product/$product/recovery.img ]; then


    # tmp copy of recovery image
    cp -f out/target/product/$product/recovery.img $recoverypath/recovery.img > /dev/null 2>compile.err

    # pack it with our prebuilt recovery package prebuilts
    cd $recoverypath
    zip -r tmp.zip * >> $helperpath/../compile.log 2>compile.err
    cd $helperpath/..

    mkdir -p $settings_dir_final

    # copy build, generate new md5 sum and save to file
    file_source="$recoverypath/tmp.zip"
    file_target="$settings_dir_final/recovery-$recovery_name.zip"
    copywmd5 $file_source $file_target > /dev/null 2>compile.err
    rm $recoverypath/recovery.img > /dev/null 2>compile.err
    rm $recoverypath/tmp.zip > /dev/null 2>compile.err

    # ... and talk to humans again
    show_success "        Recovery: $file_target"
    show_success "         MD5 sum: $md5"
    echo ""

fi
