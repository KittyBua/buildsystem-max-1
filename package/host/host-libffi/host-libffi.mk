#
# host-libffi
#
HOST_LIBFFI_VER    = 3.3
HOST_LIBFFI_DIR    = libffi-$(HOST_LIBFFI_VER)
HOST_LIBFFI_SOURCE = libffi-$(HOST_LIBFFI_VER).tar.gz
HOST_LIBFFI_SITE   = https://github.com/libffi/libffi/releases/download/v$(HOST_LIBFFI_VER)
HOST_LIBFFI_DEPS   = bootstrap

$(D)/host-libffi:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(HOST_CONFIGURE); \
		$(MAKE); \
		$(MAKE) install
	$(REMOVE)
	$(TOUCH)
