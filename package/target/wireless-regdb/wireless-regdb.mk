#
# wireless-regdb
#
WIRELESS_REGDB_VER    = 2020.04.29
WIRELESS_REGDB_DIR    = wireless-regdb-$(WIRELESS_REGDB_VER)
WIRELESS_REGDB_SOURCE = wireless-regdb-$(WIRELESS_REGDB_VER).tar.xz
WIRELESS_REGDB_SITE   = https://mirrors.edge.kernel.org/pub/software/network/wireless-regdb
WIRELESS_REGDB_DEPS   = bootstrap

$(D)/wireless-regdb:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/regulatory.db $(TARGET_FIRMWARE_DIR)/regulatory.db
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/regulatory.db.p7s $(TARGET_FIRMWARE_DIR)/regulatory.db.p7s
	$(REMOVE)
	$(TOUCH)
