#
# host-pkgconf
#
HOST_PKGCONF_VER    = 1.6.3
HOST_PKGCONF_DIR    = pkgconf-$(HOST_PKGCONF_VER)
HOST_PKGCONF_SOURCE = pkgconf-$(HOST_PKGCONF_VER).tar.xz
HOST_PKGCONF_SITE   = https://distfiles.dereferenced.org/pkgconf

$(D)/host-pkgconf: directories
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		./configure $(SILENT_OPT) \
			--prefix=$(HOST_DIR) \
			; \
		$(MAKE); \
		$(MAKE) install
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/pkgconf-config $(HOST_DIR)/bin/pkg-config
	ln -sf pkg-config $(HOST_DIR)/bin/$(TARGET)-pkg-config
	$(PKG_REMOVE)
	$(TOUCH)
