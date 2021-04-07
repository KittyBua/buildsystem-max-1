#
# host-zic
#
HOST_ZIC_VERSION = 2020f
HOST_ZIC_DIR     = tzcode
HOST_ZIC_SOURCE  = tzcode$(HOST_ZIC_VERSION).tar.gz
HOST_ZIC_SITE    = https://www.iana.org/time-zones/repository/releases
HOST_ZIC_DEPENDS = bootstrap

$(D)/host-zic:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(MKDIR)/$($(PKG)_DIR)
	$(call EXTRACT,$(PKG_BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(MAKE) zic
	$(INSTALL_EXEC) -D $(PKG_BUILD_DIR)/zic $(HOST_DIR)/bin/
	$(REMOVE)
	$(TOUCH)
