#
# host-libffi
#
HOST_LIBFFI_VER    = 3.2.1
HOST_LIBFFI_DIR    = libffi-$(HOST_LIBFFI_VER)
HOST_LIBFFI_SOURCE = libffi-$(HOST_LIBFFI_VER).tar.gz
HOST_LIBFFI_SITE   = ftp://sourceware.org/pub/libffi
HOST_LIBFFI_DEPS   = bootstrap

$(D)/host-libffi:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		./configure \
			--prefix=$(HOST_DIR) \
			--disable-static \
			; \
		$(MAKE); \
		$(MAKE) install
	$(REMOVE)
	$(TOUCH)
