#
# libffi
#
LIBFFI_VERSION = 3.3
LIBFFI_DIR     = libffi-$(LIBFFI_VERSION)
LIBFFI_SOURCE  = libffi-$(LIBFFI_VERSION).tar.gz
LIBFFI_SITE    = https://github.com/libffi/libffi/releases/download/v$(LIBFFI_VERSION)
LIBFFI_DEPENDS = bootstrap

LIBFFI_AUTORECONF = YES

LIBFFI_CONF_OPTS = \
	--disable-static \
	--enable-builddir=libffi

libffi:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
