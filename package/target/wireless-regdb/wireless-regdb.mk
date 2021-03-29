#
# wireless-regdb
#
WIRELESS_REGDB_VERSION = 2020.04.29
WIRELESS_REGDB_DIR     = wireless-regdb-$(WIRELESS_REGDB_VERSION)
WIRELESS_REGDB_SOURCE  = wireless-regdb-$(WIRELESS_REGDB_VERSION).tar.xz
WIRELESS_REGDB_SITE    = https://mirrors.edge.kernel.org/pub/software/network/wireless-regdb
WIRELESS_REGDB_DEPENDS = bootstrap

wireless-regdb:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/regulatory.db $(TARGET_FIRMWARE_DIR)/regulatory.db
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/regulatory.db.p7s $(TARGET_FIRMWARE_DIR)/regulatory.db.p7s
	$(REMOVE)
	$(TOUCH)
