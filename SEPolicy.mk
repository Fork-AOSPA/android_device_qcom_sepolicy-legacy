# Board specific SELinux policy variable definitions
ifeq ($(call is-vendor-board-platform,QCOM),true)
SEPOLICY_PATH:= device/qcom/sepolicy-legacy
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS := \
    $(SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS) \
    $(SEPOLICY_PATH)/generic/public \
    $(SEPOLICY_PATH)/generic/public/attribute

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS := \
    $(SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS) \
    $(SEPOLICY_PATH)/generic/private

SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS := \
    $(SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS) \
    $(SEPOLICY_PATH)/qva/public \
    $(SEPOLICY_PATH)/qva/public/attribute

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS := \
    $(SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS) \
    $(SEPOLICY_PATH)/qva/private

#once all the services are moved to Product /ODM above lines will be removed.
# sepolicy rules for product images
PRODUCT_PUBLIC_SEPOLICY_DIRS := \
    $(PRODUCT_PUBLIC_SEPOLICY_DIRS) \
    $(SEPOLICY_PATH)/generic/product/public \
    $(SEPOLICY_PATH)/qva/product/public 

PRODUCT_PRIVATE_SEPOLICY_DIRS := \
    $(PRODUCT_PRIVATE_SEPOLICY_DIRS) \
    $(SEPOLICY_PATH)/generic/product/private \
    $(SEPOLICY_PATH)/qva/product/private

ifeq (,$(filter sdm845 sdm710 sdm660 msm8937 msm8953 msm8998, $(TARGET_BOARD_PLATFORM)))
    BOARD_VENDOR_SEPOLICY_DIRS := \
       $(BOARD_VENDOR_SEPOLICY_DIRS) \
       $(SEPOLICY_PATH) \
       $(SEPOLICY_PATH)/generic/vendor/common \
       $(SEPOLICY_PATH)/qva/vendor/common/sysmonapp \
       $(SEPOLICY_PATH)/qva/vendor/ssg \
       $(SEPOLICY_PATH)/qva/vendor/common

    ifeq ($(TARGET_SEPOLICY_DIR),)
      BOARD_VENDOR_SEPOLICY_DIRS += $(SEPOLICY_PATH)/generic/vendor/$(TARGET_BOARD_PLATFORM)
      BOARD_VENDOR_SEPOLICY_DIRS += $(SEPOLICY_PATH)/qva/vendor/$(TARGET_BOARD_PLATFORM)
    else
      BOARD_VENDOR_SEPOLICY_DIRS += $(SEPOLICY_PATH)/generic/vendor/$(TARGET_SEPOLICY_DIR)
      BOARD_VENDOR_SEPOLICY_DIRS += $(SEPOLICY_PATH)/qva/vendor/$(TARGET_SEPOLICY_DIR)
    endif

    ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
    BOARD_VENDOR_SEPOLICY_DIRS += $(SEPOLICY_PATH)/generic/vendor/test
    BOARD_VENDOR_SEPOLICY_DIRS += $(SEPOLICY_PATH)/qva/vendor/test
    endif
endif

ifneq (,$(filter sdm845 sdm710 sdm660 msm8937 msm8953 msm8998, $(TARGET_BOARD_PLATFORM)))
    BOARD_VENDOR_SEPOLICY_DIRS := \
                 $(BOARD_VENDOR_SEPOLICY_DIRS) \
                 $(SEPOLICY_PATH) \
                 $(SEPOLICY_PATH)/legacy/vendor/common/sysmonapp \
                 $(SEPOLICY_PATH)/legacy/vendor/ssg \
                 $(SEPOLICY_PATH)/legacy/vendor/common

    ifeq ($(TARGET_SEPOLICY_DIR),)
      BOARD_VENDOR_SEPOLICY_DIRS += $(SEPOLICY_PATH)/legacy/vendor/$(TARGET_BOARD_PLATFORM)
    else
      BOARD_VENDOR_SEPOLICY_DIRS += $(SEPOLICY_PATH)/legacy/vendor/$(TARGET_SEPOLICY_DIR)
    endif
    ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
    BOARD_VENDOR_SEPOLICY_DIRS += $(SEPOLICY_PATH)/legacy/vendor/test
    endif
endif
endif
