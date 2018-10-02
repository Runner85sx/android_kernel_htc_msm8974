DEFCONFIG=m8_defconfig
OBJ_DIR=`pwd`/.out
ANYKERNEL_DIR=/home/mihran/anykernelm8
TOOLCHAIN=/home/mihran/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
ZIP_NAME="NoName-m8-beta2"
DATE=$(date +"%m-%d-%y")
export KBUILD_BUILD_USER="mihran"
export KBUILD_BUILD_HOST="northkorea"
MAKE_OPTS="ARCH=arm O=$OBJ_DIR CROSS_COMPILE=${TOOLCHAIN}"
if [ ! -d ${OBJ_DIR} ]; then
    mkdir ${OBJ_DIR}
fi

make O=${OBJ_DIR} clean
make O=${OBJ_DIR} mrproper
make ARCH=arm O=$OBJ_DIR CROSS_COMPILE=${TOOLCHAIN} $DEFCONFIG
make -j4 ${MAKE_OPTS}

rm -f ${ANYKERNEL_DIR}/Image.gz*
rm -f ${ANYKERNEL_DIR}/zImage*
rm -f ${ANYKERNEL_DIR}/dtb*
cp $OBJ_DIR/arch/arm/boot/zImage-dtb ${ANYKERNEL_DIR}/zImage-dtb
cd ${ANYKERNEL_DIR}
rm *.zip
zip -r9 ${ZIP_NAME}.zip * -x README ${ZIP_NAME}.zip
