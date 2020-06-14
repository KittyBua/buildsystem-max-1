#
# host-tzdata
#
HOST_TZCODE_VER    = 2020a
HOST_TZCODE_DIR    = tzcode
HOST_TZCODE_SOURCE = tzcode$(HOST_TZCODE_VER).tar.gz
HOST_TZCODE_URL    = ftp://ftp.iana.org/tz/releases

$(D)/host-tzcode: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(TZDATA_SOURCE))
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(MKDIR)/$(PKG_DIR)
	$(CHDIR)/$(PKG_DIR); \
		tar -xf $(DL_DIR)/$(HOST_TZCODE_SOURCE); \
		tar -xf $(DL_DIR)/$(TZDATA_SOURCE); \
		$(MAKE) zic
	$(INSTALL_EXEC) -D $(BUILD_DIR)/$(PKG_DIR)/zic $(HOST_DIR)/bin/
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
