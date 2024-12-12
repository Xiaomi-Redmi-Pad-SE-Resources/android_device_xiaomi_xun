#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),xun)
include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

PREBUILT_KERNEL_MODULES_SYSTEM_DLKM := $(TARGET_OUT_SYSTEM_DLKM)/lib/modules
$(PREBUILT_KERNEL_MODULES_SYSTEM_DLKM):
	@mkdir -p $(TARGET_OUT_SYSTEM_DLKM)/lib/modules
	@cp -r $(KERNEL_PATH)/modules/system/* $(PREBUILT_KERNEL_MODULES_SYSTEM_DLKM)
ALL_DEFAULT_INSTALLED_MODULES += $(PREBUILT_KERNEL_MODULES_SYSTEM_DLKM)

endif
