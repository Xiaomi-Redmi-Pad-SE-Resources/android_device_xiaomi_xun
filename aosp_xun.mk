#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Inherit some common PixelOS stuff.
$(call inherit-product, vendor/aosp/config/common_full_tablet_wifionly.mk)

# Inherit from device makefile.
$(call inherit-product, device/xiaomi/xun/device.mk)

PRODUCT_NAME := aosp_xun
PRODUCT_DEVICE := xun
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := 23073RPBFG

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="xun-user 14 UKQ1.231003.002 V816.0.7.0.UMUMIXM release-keys" \
    BuildFingerprint=Redmi/xun/xun:14/UKQ1.231003.002/V816.0.7.0.UMUMIXM:user/release-keys \
    DeviceName=xun \
    DeviceProduct=23073RPBFG \
    SystemDevice=23073RPBFG \
    SystemName=xun
