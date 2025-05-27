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
PRODUCT_AAPT_CONFIG := normal mdpi hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi

# Boot animation
TARGET_SCREEN_HEIGHT := 1200
TARGET_SCREEN_WIDTH := 1920

# Init scripts
PRODUCT_PACKAGES += \
    init.device.rc

# Set product characteristic to tablet, needed for some ui elements
PRODUCT_CHARACTERISTICS := tablet

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 33

# Overlays
PRODUCT_PACKAGES += \
    FrameworksResXun \
    SettingsProviderResXun \
    SettingsResXun

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/tablet_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/tablet_core_hardware.xml

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/xiaomi/xun/xun-vendor.mk)
