################################################################################
#
# wlan-rtl8822bu
#
################################################################################

WLAN_RTL8822BU_VERSION = 1.0.0.9-20180511a
WLAN_RTL8822BU_DIR     = rtl8822bu
WLAN_RTL8822BU_SOURCE  = rtl8822bu-driver-$(WLAN_RTL8822BU_VERSION).zip
WLAN_RTL8822BU_SITE    = http://source.mynonpublic.com
WLAN_RTL8822BU_DEPENDS = bootstrap kernel

define WLAN_RTL8822BU_INSTALL_BINARY
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/88x2bu.ko $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/88x2bu.ko
endef
WLAN_RTL8822BU_PRE_INSTALL_TARGET_HOOKS += WLAN_RTL8822BU_INSTALL_BINARY

define WLAN_RTL8822BU_RUN_DEPMOD
	$(LINUX_RUN_DEPMOD)
endef
WLAN_RTL8822BU_POST_INSTALL_TARGET_HOOKS += WLAN_RTL8822BU_RUN_DEPMOD

$(D)/wlan-rtl8822bu:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) $(KERNEL_MAKE_VARS)
	$(call TARGET_FOLLOWUP)
