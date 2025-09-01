#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),xun)
include $(call all-makefiles-under,$(LOCAL_PATH))

# A/B builds require us to create the mount points at compile time.
# Just creating it for all cases since it does not hurt.
FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/firmware_mnt
$(FIRMWARE_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/firmware_mnt

BT_FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/bt_firmware
$(BT_FIRMWARE_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(BT_FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/bt_firmware

DSP_MOUNT_POINT := $(TARGET_OUT_VENDOR)/dsp
$(DSP_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(DSP_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/dsp

ALL_DEFAULT_INSTALLED_MODULES += \
    $(FIRMWARE_MOUNT_POINT) \
    $(BT_FIRMWARE_MOUNT_POINT) \
    $(DSP_MOUNT_POINT)

PREBUILT_KERNEL_MODULES_SYSTEM_DLKM := $(TARGET_OUT_SYSTEM_DLKM)/lib/modules
$(PREBUILT_KERNEL_MODULES_SYSTEM_DLKM):
	@mkdir -p $(TARGET_OUT_SYSTEM_DLKM)/lib/modules
	@cp -r $(KERNEL_PATH)/modules/system/* $(PREBUILT_KERNEL_MODULES_SYSTEM_DLKM)
ALL_DEFAULT_INSTALLED_MODULES += $(PREBUILT_KERNEL_MODULES_SYSTEM_DLKM)

endif
