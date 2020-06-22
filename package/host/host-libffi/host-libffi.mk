#
# host-libffi
#
HOST_LIBFFI_VER    = 3.2.1
HOST_LIBFFI_DIR    = libffi-$(HOST_LIBFFI_VER)
HOST_LIBFFI_SOURCE = libffi-$(HOST_LIBFFI_VER).tar.gz
HOST_LIBFFI_SITE   = ftp://sourceware.org/pub/libffi

$(D)/host-libffi: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		./configure $(SILENT_OPT) \
			--prefix=$(HOST_DIR) \
			--disable-static \
			; \
		$(MAKE); \
		$(MAKE) install
	$(PKG_REMOVE)
	$(TOUCH)
