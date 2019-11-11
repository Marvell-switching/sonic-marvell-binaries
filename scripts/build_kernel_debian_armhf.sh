#!/bin/bash

declare -a FILES
declare -a MODULES
declare -a MOD_NAMES
declare -a MISC_FILES
declare -a MISC_PATH

FILES=(zImage armada-385-ET6448M_4G_Nand.dtb)
MODULES=(mvDmaDrv.ko)
MOD_NAMES=(mvDmaDrv)
MISC_FILES=(eeprom)
MISC_PATH=(/etc/sonic/)
MISC_DIR=(lib)

ARCH=armhf
VERSION=4.9.168
PKG_NAME=linux-image
TMP=${PKG_NAME}-${VERSION}-${ARCH}
DATE=`date -u`

build_deb()
{
    rm -fr ${TMP}
    mkdir -p ${TMP}/DEBIAN
    mkdir -p ${TMP}/boot/
    mkdir -p ${TMP}/lib/modules/${VERSION}/
    for f in ${FILES[*]}
    do
        if [ -f $f ]
        then
            echo "Packing $f"
            cp -v $f ${TMP}/boot/
        else
            echo "ERROR: $f NOT found"
        fi
    done
    for f in ${MODULES[*]}
    do
        if [ -f $f ]
        then
            echo "Packing $f"
            cp -v $f ${TMP}/lib/modules/${VERSION}/
        else
            echo "ERROR: $f NOT found"
        fi
    done
    for f in ${MOD_NAMES[*]}
    do
        echo "Adding kernel $f"
        mkdir -p ${TMP}/etc/modules-load.d/
        echo "$f" >> ${TMP}/etc/modules-load.d/marvell.conf
    done
    i=0
    for f in ${MISC_FILES[*]}
    do
        echo "Adding Misc $f to ${MISC_PATH[$i]}"
        mkdir -p ${TMP}/${MISC_PATH[$i]}
        cp -v $f ${TMP}/${MISC_PATH[$i]}
        i=$((i+1))
    done
    i=0
    for f in ${MISC_DIR[*]}
    do
        echo "Adding Misc $f to ${MISC_DIR[$i]}"
        cp -drv $f ${TMP}/
        i=$((i+1))
    done

    # i2c-dev is missing in modules
    mkdir -p ${TMP}/etc/modules-load.d/
    echo "i2c-dev" >> ${TMP}/etc/modules-load.d/marvell.conf
    mkdir -p ${TMP}/etc/sysctl.d/
    echo "sysctl -w net.ipv4.neigh.default.gc_thresh1=16000"    >> ${TMP}/etc/sysctl.d/98-sysctl.conf
    echo "sysctl -w net.ipv4.neigh.default.gc_thresh2=32000"    >> ${TMP}/etc/sysctl.d/98-sysctl.conf
    echo "sysctl -w net.ipv4.neigh.default.gc_thresh3=48000"    >> ${TMP}/etc/sysctl.d/98-sysctl.conf
    echo "sysctl -w net.ipv6.neigh.default.gc_thresh1=8000 "    >> ${TMP}/etc/sysctl.d/98-sysctl.conf
    echo "sysctl -w net.ipv6.neigh.default.gc_thresh2=16000"    >> ${TMP}/etc/sysctl.d/98-sysctl.conf
    echo "sysctl -w net.ipv6.neigh.default.gc_thresh3=32000"    >> ${TMP}/etc/sysctl.d/98-sysctl.conf
    FW_ENV='/dev/mtd0 \t\t 0x00500000 \t 0x80000 \t 0x100000 \t 8'
    echo -e $FW_ENV > ${TMP}/etc/fw_env.config


    echo "Package: ${PKG_NAME}-${VERSION}-${ARCH} " > ${TMP}/DEBIAN/control
    echo "Version: $VERSION" >> ${TMP}/DEBIAN/control
    echo "Section: base" >> ${TMP}/DEBIAN/control
    echo "Priority: optional" >> ${TMP}/DEBIAN/control
    echo "Architecture: $ARCH" >> ${TMP}/DEBIAN/control
    echo "Depends:" >> ${TMP}/DEBIAN/control
    echo "Maintainer: $USER <$USER@marvell.com>" >> ${TMP}/DEBIAN/control
    echo "Date: $DATE" >> ${TMP}/DEBIAN/control
    echo "Description: Linux Marvell Kernel" >> ${TMP}/DEBIAN/control
    #cat ${TMP}/DEBIAN/control
    echo "Building deb package"
    dpkg-deb --build ${TMP}

    dpkg -I ${TMP}.deb

}


build_deb
