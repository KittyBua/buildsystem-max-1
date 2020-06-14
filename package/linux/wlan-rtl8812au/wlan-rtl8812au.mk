#
# wlan-rtl8812au
#
WLAN_RTL8812AU_VER    = 4.3.14
WLAN_RTL8812AU_DIR    = rtl8812AU-driver-$(WLAN_RTL8812AU_VER)
WLAN_RTL8812AU_SOURCE = rtl8812AU-driver-$(WLAN_RTL8812AU_VER).zip
WLAN_RTL8812AU_URL    = http://source.mynonpublic.com

WLAN_RTL8812AU_PATCH  = \
	0001-rt8812au-gcc5.patch \
	0002-rt8812au-Add-support-for-kernels-4.8.patch

$(D)/wlan-rtl8812au: bootstrap kernel
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	unzip -o $(SILENT_Q) $(DL_DIR)/$(PKG_SOURCE) -d $(BUILD_DIR)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(MAKE) $(KERNEL_MAKEVARS); \
	$(INSTALL_DATA) 8812au.ko $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/
	make depmod
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
