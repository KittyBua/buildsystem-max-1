#
# wlan-rtl8822bu
#
WLAN_RTL8822BU_VERSION = 1.0.0.9-20180511a
WLAN_RTL8822BU_DIR     = rtl8822bu
WLAN_RTL8822BU_SOURCE  = rtl8822bu-driver-$(WLAN_RTL8822BU_VERSION).zip
WLAN_RTL8822BU_SITE    = http://source.mynonpublic.com
WLAN_RTL8822BU_DEPENDS = bootstrap kernel

wlan-rtl8822bu:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(MAKE) $(KERNEL_MAKEVARS); \
	$(INSTALL_DATA) 88x2bu.ko $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/
	$(LINUX_RUN_DEPMOD)
	$(REMOVE)
	$(TOUCH)
