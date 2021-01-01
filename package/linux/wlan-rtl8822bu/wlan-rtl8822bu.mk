#
# wlan-rtl8822bu
#
WLAN_RTL8822BU_VER    = 1.0.0.9-20180511a
WLAN_RTL8822BU_DIR    = rtl8822bu
WLAN_RTL8822BU_SOURCE = rtl8822bu-driver-$(WLAN_RTL8822BU_VER).zip
WLAN_RTL8822BU_SITE   = http://source.mynonpublic.com

$(D)/wlan-rtl8822bu: bootstrap kernel
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(MAKE) $(KERNEL_MAKEVARS); \
	$(INSTALL_DATA) 88x2bu.ko $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/
	$(LINUX_RUN_DEPMOD)
	$(PKG_REMOVE)
	$(TOUCH)
