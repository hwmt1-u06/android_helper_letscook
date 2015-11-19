#!/bin/bash

### defaults

release_number_major=0  # Default: 0
release_number_minor=0  # Default: 0
build_number=1          # Default: 1
kernel_version=1        # Default: 1

### get from last build

if [[ -f $helperpath/config/.last_release ]]; then
    # override from file
    read release_number_major < $helperpath/config/.last_release
fi
if [[ -f $helperpath/config/.last_release_minor ]]; then
    # override from file
    read release_number_minor < $helperpath/config/.last_release_minor
fi
if [[ -f $helperpath/config/.last_build ]]; then
    # override from file
    read build_number < $helperpath/config/.last_build
fi
if [[ -f $helperpath/config/.last_kernel ]]; then
    read kernel_version < $helperpath/config/.last_kernel
fi

### increase

# increase build number
build_number=$(( $build_number + 1 ))
# in testbuilds: include play store and OneTimeBlah for debugging
export BANGL_INCLUDE_GAPPS=1

if [[ $build_type == "beta" ]]; then
    # reset build number
    build_number=0

    # increase release minor number
    release_number_minor=$(( $release_number_minor + 1 ))

    # no gapps in releases
    unset BANGL_INCLUDE_GAPPS
elif [[ $build_type == "release" ]]; then
    # reset minor number
    release_number_minor=0
    # reset build number
    build_number=0

    # increase release number
    release_number_major=$(( $release_number_major + 1 ))

    # no gapps in releases
    unset BANGL_INCLUDE_GAPPS
fi

if [[ $kernel_update ]]; then
    # increase kernel version
    kernel_version=$(( $kernel_version + 1 ))
fi

### export

# export the "BangL Version" of the build
if [[ $build_number -gt 0 ]]; then
    export BANGL_VERSION=$settings_name-v$release_number_major.$release_number_minor.$build_number
else
    export BANGL_VERSION=$settings_name-v$release_number_major.$release_number_minor
fi

# Set kernel version
mkdir -p out/target/product/$product/obj/KERNEL_OBJ
echo "$(( $kernel_version - 1 ))" > out/target/product/$product/obj/KERNEL_OBJ/.version

### current date

# this is needed if the build process is done over midnight ;)
date=`date -u +%Y%m%d`
hour=$( printf "%02d" $(( `date -u +%k` + 1 )) ) # FIXME: dirty fix for my timezone, get real timezone instead
minute=`date -u +%M` # FIXME: this will not work. try to get the actual var from make instead (see /vendor/bliss or /vendor/carbon)
time=$hour$minute
