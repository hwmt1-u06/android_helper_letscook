#!/bin/bash
source $cmdpath/options.sh

# get version informations about rom, recovery and kernel
source $helperpath/inc/analyze.sh

# get version numbers from last build
source $helperpath/lib/versioning_pre.sh

# Prepare CCACHE
export USE_CCACHE=$settings_ccache_use
if [[ $USE_CCACHE == 1 ]]; then
    export CCACHE_DIR=$helperpath/../.ccache
    export ANDROID_CCACHE_SIZE=$settings_ccache_size
    export ANDROID_CCACHE_DIR=$CCACHE_DIR
    prebuilts/misc/linux-x86/ccache/ccache -M $ANDROID_CCACHE_SIZE > /dev/null 2>&1
fi

# Get prebuilts
vendor/cm/get-prebuilts > /dev/null 2>&1

# tell dem humans whats cookin
###########################################
#clear
echo ""
if [[ $rom_type == "cm" ]]; then
    echo "CyanogenMod $cm_version"
elif [[ $rom_type == "bliss" ]]; then
    echo "Bliss Stalk"
elif [[ $rom_type == "carbon" ]]; then
    echo "CarbonROM"
else
    echo "Unknown ROM"
fi
echo ""
echo " android: $android_version"
if [[ $rom_type == "bliss" ]] || [[ $rom_type == "carbon" ]]; then
    echo " date: $date-$time"
else
    echo " date: $date"
fi
echo " product: $product"
echo " build: $BANGL_VERSION"
echo " kernel-build: #$kernel_version"
recovery_name=$recovery_version-$product-$settings_name-$date
echo " recovery: $recovery_version"
echo ""

# build
###########################################

rm compile.log > /dev/null 2>&1
rm compile.err > /dev/null 2>&1

source $helperpath/../build/envsetup.sh >/dev/null

if [[ $verbose ]]; then
    echo "Building Rom..."
    brunch $product userdebug -j$settings_threads
else
    echo "Build process started. Open 2 more terminal and type 'tail -f compile.log' and 'tail -f compile.err' in them, if you wanna see the logs live"
    brunch $product userdebug -j$settings_threads >> compile.log 2>>compile.err
fi

# pack
###########################################
source $helperpath/inc/pack_rom.sh

# If build was successful
if [[ -f $file_source ]]; then
    # Talk to humans
    show_success "Build successful: $file_target"
    show_success "         MD5 sum: $md5"
    echo ""
else
    # oh s***, theres no zip

    # TODO FIXME : there is a problem with bliss and carbon: bliss and carbon are including build hour and minute into their zip name.
    #               sometimes, when you start building at like xx:59, things will get out of sync.
    #               we have two options here:
    #                   1. get real var, used by rom from makefile. is that even possible? (in build_analyze.sh)
    #                   2. change android core of bliss and carbon to not do this hour/minute crap, and fall back to day only. (probably in build/ OR vendor/bliss/ OR carbon/ OR system/core/)
    show_error "Build failed! (Do not trust this message on bliss or carbon yet. The build might actually be okay. Look into 'compile.log' for the truth! [will be fixed soon.])"

    if [[ ! $verbose ]]; then
        tail -n 20 compile.err
        show_warning "Read the full compile.log file if this excerpt doesn't give enough information about the error."
    fi
    exit 1
fi

source $helperpath/inc/pack_recovery.sh
source $helperpath/inc/pack_kernel.sh
