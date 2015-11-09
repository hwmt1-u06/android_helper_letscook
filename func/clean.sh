#!/bin/bash

function clean_kernel() {
    rm -r out/target/product/$1/obj/KERNEL_OBJ > /dev/null 2>&1
    rm -r out/target/product/$1/system/lib/modules > /dev/null 2>&1
    rm out/target/product/$1/kernel > /dev/null 2>&1

}

function clean_recovery() {
    rm -r out/target/product/$1/obj/PACKAGING > /dev/null 2>&1
    rm -r out/target/product/$1/obj/RECOVERY_EXECUTABLES > /dev/null 2>&1
    rm -r out/target/product/$1/obj/RECOVERY_EXECUTABLES_LOCAL > /dev/null 2>&1
    rm -r out/target/product/$1/recovery > /dev/null 2>&1
    rm -r out/target/product/$1/root > /dev/null 2>&1
    clean_kernel $1

}

function clean_quick() {
    rm -r out/target/product/$1/data > /dev/null 2>&1
    rm -r out/target/product/$1/external > /dev/null 2>&1
    rm -r out/target/product/$1/fake_packages > /dev/null 2>&1
    rm -r out/target/product/$1/install > /dev/null 2>&1
    rm -r out/target/product/$1/symbols > /dev/null 2>&1
    rm -r out/target/product/$1/system > /dev/null 2>&1
    rm out/target/product/$1/*.img > /dev/null 2>&1
    rm out/target/product/$1/*.cpio > /dev/null 2>&1
    rm out/target/product/$1/*.zip > /dev/null 2>&1
    rm out/target/product/$1/*.md5sum > /dev/null 2>&1
    clean_recovery $1
}
