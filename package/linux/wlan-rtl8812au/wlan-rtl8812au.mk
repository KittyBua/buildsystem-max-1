#
# wlan-rtl8812au
#
WLAN_RTL8812AU_VER    = 4.3.14
WLAN_RTL8812AU_DIR    = rtl8812AU-driver-$(WLAN_RTL8812AU_VER)
WLAN_RTL8812AU_SOURCE = rtl8812AU-driver-$(WLAN_RTL8812AU_VER).zip
WLAN_RTL8812AU_SITE   = http://source.mynonpublic.com
WLAN_RTL8812AU_DEPS   = bootstrap kernel

$(D)/wlan-rtl8812au:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(MAKE) $(KERNEL_MAKEVARS); \
	$(INSTALL_DATA) 8812au.ko $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/
	$(LINUX_RUN_DEPMOD)
	$(REMOVE)
	$(TOUCH)
