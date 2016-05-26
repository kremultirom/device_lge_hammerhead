#!/bin/sh
# $1 - path to top of android build tree
# $2 path to /multirom/enc folder in installation zip

QCOM_KEYMASTER_FILES="keymaster.b00 keymaster.b01 keymaster.b02 keymaster.b03 keymaster.mdt"
QCOM_CMNLIB_FILES="cmnlib.b00 cmnlib.b01 cmnlib.b02 cmnlib.b03 cmnlib.mdt"
QCOM_LIB_FILES="libQSEEComAPI.so"
QCOM_PATH="$1/vendor/lge/hammerhead/proprietary/"

cp -a "${QCOM_PATH}/lib/libQSEEComAPI.so" "$2/"

# libQSEEComApi depends on libutils. These are built from omni source and libutils
# is modified to drop libbacktrace dependency
cp -an "$1/device/lge/hammerhead/multirom/libutils.so" "$2/"
cp -an "$1/device/lge/hammerhead/multirom/libstlport.so" "$2/"

mkdir -p "$2/vendor/firmware/keymaster"
mkdir -p "$2/vendor/lib/hw/"
cp -a "$1/device/lge/hammerhead/recovery/keystore.msm8974.so" "$2/vendor/lib/hw/keystore.default.so"

for f in $QCOM_CMNLIB_FILES; do
    cp -a "${QCOM_PATH}/vendor/firmware/${f}" "$2/vendor/firmware/"
done

for f in $QCOM_KEYMASTER_FILES; do
    cp -a "${QCOM_PATH}/vendor/firmware/keymaster/${f}" "$2/vendor/firmware/keymaster/"
done
