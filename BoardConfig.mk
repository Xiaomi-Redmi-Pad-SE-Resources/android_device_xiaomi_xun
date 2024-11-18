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
PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,$(KERNEL_PATH)/modules/system_dlkm/,$(TARGET_COPY_OUT_SYSTEM_DLKM)/lib/modules/5.15.94) \
    $(call find-copy-subdir-files,*,$(KERNEL_PATH)/modules/vendor_dlkm/,$(TARGET_COPY_OUT_VENDOR_DLKM)/lib/modules) \
    $(call find-copy-subdir-files,*,$(KERNEL_PATH)/modules/vendor_ramdisk/,$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules)

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
