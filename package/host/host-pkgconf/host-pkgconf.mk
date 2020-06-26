#
# host-pkgconf
#
HOST_PKGCONF_VER    = 1.6.3
HOST_PKGCONF_DIR    = pkgconf-$(HOST_PKGCONF_VER)
HOST_PKGCONF_SOURCE = pkgconf-$(HOST_PKGCONF_VER).tar.xz
HOST_PKGCONF_SITE   = https://distfiles.dereferenced.org/pkgconf

HOST_PKGCONF_PATCH  = \
	0001-Only-prefix-with-the-sysroot-a-subset-of-variables.patch \
	0002-Revert-main-assume-modversion-insted-of-version-if-o.patch

$(D)/host-pkgconf: directories
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		./configure $(SILENT_OPT) \
			--prefix=$(HOST_DIR) \
			; \
		$(MAKE); \
		$(MAKE) install
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/pkgconf-pkg-config $(HOST_DIR)/bin/pkg-config
	ln -sf pkg-config $(HOST_DIR)/bin/$(TARGET)-pkg-config
	$(PKG_REMOVE)
	$(TOUCH)
