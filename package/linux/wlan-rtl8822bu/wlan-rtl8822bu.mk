################################################################################
#
# wlan-rtl8822bu
#
################################################################################

WLAN_RTL8822BU_VERSION = 1.0.0.9-20180511a
WLAN_RTL8822BU_DIR = rtl8822bu
WLAN_RTL8822BU_SOURCE = rtl8822bu-driver-$(WLAN_RTL8822BU_VERSION).zip
WLAN_RTL8822BU_SITE = http://source.mynonpublic.com

WLAN_RTL8822BU_DEPENDS = kernel

define WLAN_RTL8822BU_INSTALL_BINARY
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/88x2bu.ko $(TARGET_MODULES_DIR)/kernel/drivers/net/wireless/88x2bu.ko
endef
WLAN_RTL8822BU_POST_BUILD_HOOKS += WLAN_RTL8822BU_INSTALL_BINARY

$(D)/wlan-rtl8822bu: | bootstrap
	$(call kernel-module)
