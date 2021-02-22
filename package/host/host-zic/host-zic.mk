#
# host-zic
#
HOST_ZIC_VER    = 2020f
HOST_ZIC_DIR    = tzcode
HOST_ZIC_SOURCE = tzcode$(HOST_ZIC_VER).tar.gz
HOST_ZIC_SITE   = https://www.iana.org/time-zones/repository/releases
HOST_ZIC_DEPS   = bootstrap

$(D)/host-zic:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(MKDIR)/$($(PKG)_DIR)
	$(call EXTRACT,$(PKG_BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(MAKE) zic
	$(INSTALL_EXEC) -D $(PKG_BUILD_DIR)/zic $(HOST_DIR)/bin/
	$(REMOVE)
	$(TOUCH)
