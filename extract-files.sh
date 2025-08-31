#!/bin/bash
#
# SPDX-FileCopyrightText: 2018-2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=xun
VENDOR=xiaomi

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

export TARGET_ENABLE_CHECKELF=true

# If XML files don't have comments before the XML header, use this flag
# Can still be used with broken XML files by using blob_fixup
export TARGET_DISABLE_XML_FIXING=true

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

ONLY_FIRMWARE=
KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        --only-firmware)
            ONLY_FIRMWARE=true
            ;;
        -n | --no-cleanup)
            CLEAN_VENDOR=false
            ;;
        -k | --kang)
            KANG="--kang"
            ;;
        -s | --section)
            SECTION="${2}"
            shift
            CLEAN_VENDOR=false
            ;;
        *)
            SRC="${1}"
            ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
        odm/etc/*_build.prop)
            [ "$2" = "" ] && return 0
            sed -i "/marketname/d" "${2}"
            sed -i "s/cert/model/" "${2}"
            ;;
        system_ext/lib64/libwfdmmsrc_system.so)
            [ "$2" = "" ] && return 0
            grep -q "libgui_shim.so" "${2}" || ${PATCHELF} --add-needed "libgui_shim.so" "${2}"
            ;;
        system_ext/lib64/libwfdnative.so)
            [ "$2" = "" ] && return 0
            grep -q "libbinder_shim.so" "${2}" || ${PATCHELF} --add-needed "libbinder_shim.so" "${2}"
            grep -q "libinput_shim.so" "${2}" || ${PATCHELF} --add-needed "libinput_shim.so" "${2}"
            ;;
        system_ext/lib64/libwfdservice.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --replace-needed "android.media.audio.common.types-V2-cpp.so" "android.media.audio.common.types-V4-cpp.so" "${2}"
            ;;
        vendor/bin/hw/android.hardware.security.keymint-service-qti|vendor/lib64/libqtikeymint.so)
            [ "$2" = "" ] && return 0
            grep -q "android.hardware.security.rkp-V3-ndk.so" "${2}" || ${PATCHELF} --add-needed "android.hardware.security.rkp-V3-ndk.so" "${2}"
            ;;
        vendor/bin/hw/vendor.qti.hardware.display.composer-service        |\
        vendor/bin/hw/vendor.xiaomi.hardware.displayfeature@1.0-service   |\
        vendor/lib64/hw/vendor.xiaomi.hardware.displayfeature@1.0-impl.so |\
        vendor/lib64/libdisplayfeatureservice.so                          |\
        vendor/lib64/libsdmcore.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --replace-needed "vendor.xiaomi.hardware.displayfeature@1.0.so" "libvendor.xiaomi.hardware.displayfeature@1.0.so" "${2}"
            ;;
        vendor/lib64/libdlbdsservice.so           |\
        vendor/lib*/libdlbpreg.so                 |\
        vendor/lib*/libqc2audio_hwaudiocodec.so   |\
        vendor/lib64/hw/displayfeature.default.so |\
        vendor/lib*/soundfx/libdlbvol.so          |\
        vendor/lib*/soundfx/libhwdap.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF}" --replace-needed "libstagefright_foundation.so" "libstagefright_foundation-v33.so" "${2}"
            ;;
        vendor/lib64/vendor.libdpmframework.so)
            [ "$2" = "" ] && return 0
            grep -q "libhidlbase_shim.so" "${2}" || ${PATCHELF} --add-needed "libhidlbase_shim.so" "${2}"
            ;;
        *)
            return 1
            ;;
    esac

    return 0
}

function blob_fixup_dry() {
    blob_fixup "$1" ""
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

if [ -z "${ONLY_FIRMWARE}" ]; then
    extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
fi

if [ -z "${SECTION}" ]; then
    extract_firmware "${MY_DIR}/proprietary-firmware.txt" "${SRC}"
fi


"${MY_DIR}/setup-makefiles.sh"
