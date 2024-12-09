#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Include the common OEM chipset BoardConfig.
include device/xiaomi/sm6225-common/BoardConfigCommon.mk

# Display
TARGET_SCREEN_DENSITY := 280

# DTBO
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbo.img

# Kernel
TARGET_NO_KERNEL_OVERRIDE := true
LOCAL_KERNEL := $(KERNEL_PATH)/kernel
PRODUCT_COPY_FILES += \
	$(LOCAL_KERNEL):kernel

# Kernel modules
DLKM_MODULES_PATH := $(KERNEL_PATH)/modules/vendor
RAMDISK_MODULES_PATH := $(KERNEL_PATH)/modules/ramdisk
SYSTEM_DLKM_MODULES_PATH := $(KERNEL_PATH)/modules/system

PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,$(SYSTEM_DLKM_MODULES_PATH)/,$(TARGET_COPY_OUT_SYSTEM_DLKM)/lib/modules/5.15.123/)

BOARD_VENDOR_KERNEL_MODULES := $(wildcard $(DLKM_MODULES_PATH)/*.ko)
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(patsubst %,$(DLKM_MODULES_PATH)/%,$(shell cat $(DLKM_MODULES_PATH)/modules.load))
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(DLKM_MODULES_PATH)/modules.blocklist

BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(wildcard $(RAMDISK_MODULES_PATH)/*.ko)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(patsubst %,$(RAMDISK_MODULES_PATH)/%,$(shell cat $(RAMDISK_MODULES_PATH)/modules.load))
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD  := $(patsubst %,$(RAMDISK_MODULES_PATH)/%,$(shell cat $(RAMDISK_MODULES_PATH)/modules.load.recovery))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(RAMDISK_MODULES_PATH)/modules.blocklist

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/configs/properties/vendor.prop

# Recovery
TARGET_RECOVERY_DEFAULT_ROTATION := ROTATION_LEFT

# VINTF
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/configs/vintf/manifest.xml

# Workaround to make lineage's soong generator work
TARGET_KERNEL_SOURCE := $(KERNEL_PATH)/kernel-headers

# Inherit the proprietary files
include vendor/xiaomi/xun/BoardConfigVendor.mk
