#
# wlan-rtl8822bu
#
WLAN_RTL8822BU_VER    = 1.0.0.9-20180511a
WLAN_RTL8822BU_DIR    = rtl8822bu
WLAN_RTL8822BU_SOURCE = rtl8822bu-driver-$(WLAN_RTL8822BU_VER).zip
WLAN_RTL8822BU_SITE   = http://source.mynonpublic.com

WLAN_RTL8822BU_PATCH = \
	0001-add-linux-4.19-support.patch \
	0002-add-linux-4.20-support.patch \
	0003-add-linux-5.0-support.patch \
	0004-add-linux-5.1-support.patch \
	0005-add-linux-5.2-support.patch

$(D)/wlan-rtl8822bu: bootstrap kernel
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches,$(PKG_PATCH)); \
		$(MAKE) $(KERNEL_MAKEVARS); \
	$(INSTALL_DATA) 88x2bu.ko $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/
	make depmod
	$(PKG_REMOVE)
	$(TOUCH)
