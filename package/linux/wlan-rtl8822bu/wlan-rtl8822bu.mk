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

$(D)/wlan-rtl8822bu:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) $(KERNEL_MAKEVARS); \
	$(INSTALL_DATA) 88x2bu.ko $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/
	$(LINUX_RUN_DEPMOD)
	$(call TARGET_FOLLOWUP)
