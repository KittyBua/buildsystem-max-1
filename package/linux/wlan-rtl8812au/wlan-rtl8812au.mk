################################################################################
#
# wlan-rtl8812au
#
################################################################################

WLAN_RTL8812AU_VERSION = 4.3.14
WLAN_RTL8812AU_DIR     = rtl8812AU-driver-$(WLAN_RTL8812AU_VERSION)
WLAN_RTL8812AU_SOURCE  = rtl8812AU-driver-$(WLAN_RTL8812AU_VERSION).zip
WLAN_RTL8812AU_SITE    = http://source.mynonpublic.com
WLAN_RTL8812AU_DEPENDS = bootstrap kernel

$(D)/wlan-rtl8812au:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) $(KERNEL_MAKEVARS); \
	$(INSTALL_DATA) 8812au.ko $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/
	$(LINUX_RUN_DEPMOD)
	$(call TARGET_FOLLOWUP)
