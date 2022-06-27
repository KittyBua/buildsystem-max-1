################################################################################
#
# host-zic
#
################################################################################

HOST_ZIC_VERSION = 2021b
HOST_ZIC_DIR     = tzcode
HOST_ZIC_SOURCE  = tzcode$(HOST_ZIC_VERSION).tar.gz
HOST_ZIC_SITE    = https://www.iana.org/time-zones/repository/releases
HOST_ZIC_DEPENDS = bootstrap

define HOST_ZIC_INSTALL_DIR
	$(MKDIR)/$($(PKG)_DIR)
endef
HOST_ZIC_PRE_EXTRACT_HOOKS += HOST_ZIC_INSTALL_DIR

$(D)/host-zic:
	$(call STARTUP)
	$(call CLEANUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(PKG_BUILD_DIR))
	$(call APPLY_PATCHES,$(PKG_PATCHES_DIR))
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) zic
	$(INSTALL_EXEC) -D $(PKG_BUILD_DIR)/zic $(HOST_DIR)/bin/
	$(call TARGET_FOLLOWUP)
