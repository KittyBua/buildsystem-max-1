################################################################################
#
# host-zic
#
################################################################################

ZIC_VERSION = 2021b
ZIC_DIR = tzcode
ZIC_SOURCE = tzcode$(HOST_ZIC_VERSION).tar.gz
ZIC_SITE = https://www.iana.org/time-zones/repository/releases

define HOST_ZIC_INSTALL_DIR
	$(MKDIR)/$($(PKG)_DIR)
endef
HOST_ZIC_PRE_EXTRACT_HOOKS += HOST_ZIC_INSTALL_DIR

$(D)/host-zic: | bootstrap
	$(call STARTUP)
	$(call CLEANUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(PKG_BUILD_DIR))
	$(call APPLY_PATCHES,$(PKG_PATCHES_DIR))
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) zic
	$(INSTALL_EXEC) -D $(PKG_BUILD_DIR)/zic $(HOST_DIR)/bin/
	$(call TARGET_FOLLOWUP)
