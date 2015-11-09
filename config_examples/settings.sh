#!/bin/bash

# packing
settings_dir_final=releases         # this is the folder where your final packages will be placed
settings_name=somebody                 # this should be something like your name

# device specific settings
settings_default_product=hwmt1_u06
settings_default_recovery_block=/dev/block/mmcblk0p11   # do NOT use the flash command, if you are not sure about this!

# ccache
settings_ccache_use=1
settings_ccache_size=5G

# build machine settings
settings_threads=4                  # set this to the count of your cpu cores
use_archfix=0                       # set this to 1, if you are building on archlinux, and execute the following:
                                        # yaourt -S make-3.81 python2
                                        # ln -s /usr/bin/make-3.81 /opt/android-build/make
                                        # ln -s /usr/bin/python2 /opt/android-build/python
