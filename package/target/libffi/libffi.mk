#
# libffi
#
LIBFFI_VER    = 3.2.1
LIBFFI_DIR    = libffi-$(LIBFFI_VER)
LIBFFI_SOURCE = libffi-$(LIBFFI_VER).tar.gz
LIBFFI_SITE   = ftp://sourceware.org/pub/libffi
LIBFFI_DEPS   = bootstrap

LIBFFI_CONF_OPTS = \
	--disable-static \
	--enable-builddir=libffi

$(D)/libffi:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
