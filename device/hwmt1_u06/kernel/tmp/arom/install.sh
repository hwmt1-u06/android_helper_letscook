#!/sbin/sh

###########################################################
# Methods
###########################################################

ui_print() {
    echo ui_print "$@" 1>&$UPDATE_CMD_PIPE;
    if [ -n "$@" ]; then
        echo ui_print 1>&$UPDATE_CMD_PIPE;
    fi
}

fatal() {
    ui_print "$@";
    exit 1;
}

###########################################################
# Constants
###########################################################

basedir=`dirname $0`
BB=$basedir/busybox
gunzip="$BB gunzip"
cpio="$BB cpio"
dd="$BB dd"
find="$BB find"
gzip="$BB gzip"
warning=0

###########################################################
# Welcome message
###########################################################

ui_print ""
ui_print "*******************************************"
ui_print "*   AROM-Kernel for Huawei Ascend Mate    *"
ui_print "*              by ANGEL-Group             *"
ui_print "*******************************************"
ui_print ""

###########################################################
# Compatibility check
###########################################################
ui_print "-- Compatibility check --"

kk=`cat /system/build.prop | awk '/version.release=4.4/ { printf "1"; exit 0 }'`
twrp=`cat /tmp/recovery.log | awk '/TWRP 2.8./ { printf "1"; exit 0 }'`
if [ "$twrp" == "1" ]; then
    ui_print "Installing from TWRP v2.8.x"
else
    ui_print "WARNING: Installing from unsupported recovery!"
    warning=$((warning + 1))
fi
if [ "$kk" != "1" ]; then
    fatal "Current ROM not compatible! Aborting."
fi

ui_print "OK"
ui_print ""

###########################################################
# Kernel installation
###########################################################
ui_print "-- Kernel installation --"

ui_print "Dumping previous boot image to $basedir/boot.old ..."
cd $basedir
$dd if=/dev/block/mmcblk0p12 of=$basedir/boot.old
if [ ! -f $basedir/boot.old ]; then
    fatal "ERROR: Dumping old boot image failed"
fi

ui_print "Extracting ramdisk from old boot image ..."
ramdisk="$basedir/boot.old-ramdisk.gz"
$basedir/unpackbootimg -i $basedir/boot.old -o $basedir/
if [ "$?" -ne 0 -o ! -f $ramdisk ]; then
    fatal "ERROR: Unpacking old boot image failed"
fi

ui_print "Unpacking ramdisk ..."
mkdir $basedir/ramdisk
cd $basedir/ramdisk
$gunzip -c $basedir/boot.old-ramdisk.gz | $cpio -i
if [ ! -f init.rc ]; then
    fatal "ERROR: Unpacking ramdisk failed!"
elif [ ! -f init.k3v2oem1.rc ]; then
    fatal "ERROR: Invalid ramdisk! Is this an Huawei Ascend Mate?"
fi

ui_print "Building new ramdisk ..."
$find . | $cpio -o -H newc | $gzip > $basedir/boot.img-ramdisk.gz
if [ "$?" -ne 0 -o ! -f $basedir/boot.img-ramdisk.gz ]; then
    fatal "ERROR: Ramdisk building failed!"
fi

ui_print "Packing new boot image ..."
cd $basedir
$basedir/mkbootimg --kernel $basedir/zImage --ramdisk $basedir/boot.img-ramdisk.gz --cmdline "vmalloc=384M k3v2_pmem=1 mmcparts=mmcblk0:p1(xloader),p3(nvme),p4(misc),p5(splash),p6(oeminfo),p7(reserved1),p8(reserved2),p9(splash2),p10(recovery2),p11(recovery),p12(boot),p13(modemimage),p14(modemnvm1),p15(modemnvm2),p16(system),p17(cache),p18(cust),p19(userdata);mmcblk1:p1(ext_sdcard)" -o $basedir/boot.img --base 0x00000000 --pagesize 2048 --ramdisk_offset 0x01400000
if [ "$?" -ne 0 -o ! -f boot.img ]; then
    fatal "ERROR: Packing boot image failed!"
fi

ui_print "Flashing the new boot image ..."
$dd if=/dev/zero of=/dev/block/mmcblk0p12
$dd if=$basedir/boot.img of=/dev/block/mmcblk0p12
if [ "$?" -ne 0 ]; then
    fatal "ERROR: Flashing boot image failed!"
fi

ui_print "Deleting old kernel modules ..."
rm -rf /system/lib/modules
mkdir /system/lib/modules

ui_print "Installing new kernel modules ..."
cp -r $basedir/modules/* /system/lib/modules
if [ "$?" -ne 0 -o ! -d /system/lib/modules ]; then
    ui_print "WARNING: kernel modules not installed!"
    warning=$((warning + 1))
fi

ui_print "OK"
ui_print ""


ui_print "Unmounting partitions..."
umount /system
umount /cache

ui_print ""
if [ $warning -gt 1 ]; then
    ui_print "AROM-Kernel installed with $warning warnings."
elif [ $warning -gt 0 ]; then
    ui_print "AROM-Kernel installed with $warning warning."
else
    ui_print "AROM-Kernel installed. Enjoy!"
fi