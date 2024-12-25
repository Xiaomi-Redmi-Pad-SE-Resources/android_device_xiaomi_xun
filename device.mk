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

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := mdpi

# Boot animation
TARGET_SCREEN_HEIGHT := 1200
TARGET_SCREEN_WIDTH := 1920

# DTB
PRODUCT_COPY_FILES += \
    $(KERNEL_PATH)/dtb:dtb.img

# Set product characteristic to tablet, needed for some ui elements
PRODUCT_CHARACTERISTICS := tablet

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 33

# Overlays
PRODUCT_PACKAGES += \
    FrameworksResXun

# Perf
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/perf/perfboostsconfig.xml:$(TARGET_COPY_OUT_VENDOR)/etc/perf/perfboostsconfig.xml \
    $(DEVICE_PATH)/configs/perf/perfconfigstore.xml:$(TARGET_COPY_OUT_VENDOR)/etc/perf/perfconfigstore.xml

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/xiaomi/xun/xun-vendor.mk)
