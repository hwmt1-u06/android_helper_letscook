#!/bin/bash

source $helperpath/lib/copywmd5.sh

mkdir -p $settings_dir_final

if [ $rom_type == "cm" ]; then
    file_source="out/target/product/$product/cm-$cm_version-$date-UNOFFICIAL-$product.zip"
    file_target="$settings_dir_final/cm-$cm_version-$product-$BANGL_VERSION.zip"
elif [ $rom_type == "bliss" ]; then
    i=0
    file_source="dummy/bullshit/which/will/probably/never/be/an/existing/file"
    while [[ $i -lt 60 ]] && ! [[ -f $file_source ]]; do # FIXME: workaround for onknown time offset between starting build and generating config
        file_source="out/target/product/$product/bliss_$product-v$android_version.002-$date-$hour$( printf "%02d" $(( $minute + $i )) ).zip"
        let i=i+1
    done
    file_target="$settings_dir_final/bliss-$product-$BANGL_VERSION.zip"
elif [ $rom_type == "carbon" ]; then
    i=0
    file_source="dummy/bullshit/which/will/probably/never/be/an/existing/file"
    while [[ $i -lt 60 ]] && ! [[ -f $file_source ]]; do # FIXME: workaround for onknown time offset between starting build and generating config
        file_source="out/target/product/$product/CARBON-KK-UNOFFICIAL-$date-$hour$( printf "%02d" $(( $minute + $i )) )-$product.zip"
        let i=i+1
    done
    file_target="$settings_dir_final/carbon-$product-$BANGL_VERSION.zip"
fi

# If build was successful
if [[ -f $file_source ]]; then
    # copy build, generate new md5 sum and save to file
    copywmd5 $file_source $file_target > /dev/null 2>compile.err

    # increase version number for next build
    source $helperpath/lib/versioning_post.sh
fi
