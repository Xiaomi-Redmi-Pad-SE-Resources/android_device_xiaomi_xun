#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from the common OEM chipset makefile.
$(call inherit-product, device/xiaomi/sm6225-common/common.mk)

DEVICE_PATH := device/xiaomi/xun
KERNEL_PATH := $(DEVICE_PATH)-kernel
TARGET_IS_TABLET := true

# DTB
PRODUCT_COPY_FILES += \
    $(KERNEL_PATH)/dtb:dtb.img

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 33

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/xiaomi/xun/xun-vendor.mk)
