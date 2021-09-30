#
# host-pkgconf
#
HOST_PKGCONF_VERSION = 1.8.0
HOST_PKGCONF_DIR     = pkgconf-$(HOST_PKGCONF_VERSION)
HOST_PKGCONF_SOURCE  = pkgconf-$(HOST_PKGCONF_VERSION).tar.xz
HOST_PKGCONF_SITE    = https://distfiles.dereferenced.org/pkgconf
HOST_PKGCONF_DEPENDS = directories

PKG_CONFIG_HOST_BINARY = $(HOST_DIR)/bin/pkg-config

$(D)/host-pkgconf:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(HOST_CONFIGURE); \
		$(MAKE); \
		$(MAKE) install
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/pkgconf-config $(HOST_DIR)/bin/pkg-config
	ln -sf pkg-config $(HOST_DIR)/bin/$(GNU_TARGET_NAME)-pkg-config
	$(REMOVE)
	$(TOUCH)
