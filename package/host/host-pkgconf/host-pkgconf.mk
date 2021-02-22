#
# host-pkgconf
#
HOST_PKGCONF_VER    = 1.6.3
HOST_PKGCONF_DIR    = pkgconf-$(HOST_PKGCONF_VER)
HOST_PKGCONF_SOURCE = pkgconf-$(HOST_PKGCONF_VER).tar.xz
HOST_PKGCONF_SITE   = https://distfiles.dereferenced.org/pkgconf
HOST_PKGCONF_DEPS   = directories

$(D)/host-pkgconf:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		./configure \
			--prefix=$(HOST_DIR) \
			; \
		$(MAKE); \
		$(MAKE) install
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/pkgconf-config $(HOST_DIR)/bin/pkg-config
	ln -sf pkg-config $(HOST_DIR)/bin/$(GNU_TARGET_NAME)-pkg-config
	$(REMOVE)
	$(TOUCH)
