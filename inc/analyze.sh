#!/bin/bash

# get ROM version/type from code
###########################################

if [[ -d "vendor/cm" ]]; then
    cm_major=`cat vendor/cm/config/common.mk | grep -o "PRODUCT_VERSION_MAJOR = .*" | grep -o "[0-9]*"`
    cm_minor=`cat vendor/cm/config/common.mk | grep -o "PRODUCT_VERSION_MINOR = .*" | grep -o "[0-9]*"`
    if [[ $cm_minor == 0 ]]; then
        cm_version="$cm_major"
    else
        cm_version="$cm_major.$cm_minor"
    fi
    rom_type="cm"
elif [[ -d "vendor/bliss" ]]; then
    rom_type="bliss"
elif [[ -d "vendor/carbon" ]]; then
    rom_type="carbon"
fi

# get ANDROID version from code
###########################################

android_version=`cat build/core/version_defaults.mk | grep -o "PLATFORM_VERSION.*" | grep -o "[0-9.]*"`

# get RECOVERY version/type from code
###########################################

# CWM
recovery_type=`cat bootable/recovery/Android.mk | grep -o "RECOVERY_NAME.*" | grep -o ":= .*" | grep -o "CWM\-" | grep -o "CWM"`
recovery_version=$recovery_type-`cat bootable/recovery/Android.mk | grep -o "RECOVERY_VERSION.*" | grep -o "v[0-9.]*" | grep -o "[0-9.]*"`

# TWRP
if [[ $recovery_type == "" ]] && [[ -f bootable/recovery/variables.h ]]; then
    recovery_type="TWRP"
    recovery_version=$recovery_type-`cat bootable/recovery/variables.h | grep -o "TW_VERSION_STR.*" | grep -o "[0-9.]*"`
fi

# Fallback
if [[ $recovery_type == "" ]]; then
    recovery_type="Unknown"
fi

