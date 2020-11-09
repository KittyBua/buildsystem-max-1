#
# host-tzcode
#
HOST_TZCODE_VER    = 2020d
HOST_TZCODE_DIR    = tzcode
HOST_TZCODE_SOURCE = tzcode$(HOST_TZCODE_VER).tar.gz
HOST_TZCODE_SITE   = ftp://ftp.iana.org/tz/releases

$(D)/host-tzcode: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(TZDATA_SOURCE))
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(MKDIR)/$(PKG_DIR)
	$(PKG_CHDIR); \
		tar -xf $(DL_DIR)/$(HOST_TZCODE_SOURCE); \
		tar -xf $(DL_DIR)/$(TZDATA_SOURCE); \
		$(MAKE) zic
	$(INSTALL_EXEC) -D $(PKG_BUILD_DIR)/zic $(HOST_DIR)/bin/
	$(PKG_REMOVE)
	$(TOUCH)
