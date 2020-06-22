#
# wlan-rtl8812au
#
WLAN_RTL8812AU_VER    = 4.3.14
WLAN_RTL8812AU_DIR    = rtl8812AU-driver-$(WLAN_RTL8812AU_VER)
WLAN_RTL8812AU_SOURCE = rtl8812AU-driver-$(WLAN_RTL8812AU_VER).zip
WLAN_RTL8812AU_SITE   = http://source.mynonpublic.com

WLAN_RTL8812AU_PATCH  = \
	0001-rt8812au-gcc5.patch \
	0002-rt8812au-Add-support-for-kernels-4.8.patch

$(D)/wlan-rtl8812au: bootstrap kernel
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(MAKE) $(KERNEL_MAKEVARS); \
	$(INSTALL_DATA) 8812au.ko $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/
	make depmod
	$(PKG_REMOVE)
	$(TOUCH)
