#
# host-libffi
#
HOST_LIBFFI_VERSION = 3.3
HOST_LIBFFI_DIR     = libffi-$(HOST_LIBFFI_VERSION)
HOST_LIBFFI_SOURCE  = libffi-$(HOST_LIBFFI_VERSION).tar.gz
HOST_LIBFFI_SITE    = https://github.com/libffi/libffi/releases/download/v$(HOST_LIBFFI_VERSION)
HOST_LIBFFI_DEPENDS = bootstrap

HOST_LIBFFI_CONF_OPTS = \
	--disable-static

host-libffi:
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
