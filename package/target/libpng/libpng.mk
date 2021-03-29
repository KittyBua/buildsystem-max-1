#
# libpng
#
LIBPNG_VERSION   = 1.6.37
LIBPNG_VERSION_X = 16
LIBPNG_DIR       = libpng-$(LIBPNG_VERSION)
LIBPNG_SOURCE    = libpng-$(LIBPNG_VERSION).tar.xz
LIBPNG_SITE      = https://sourceforge.net/projects/libpng/files/libpng$(LIBPNG_VERSION_X)/$(LIBPNG_VERSION)
LIBPNG_DEPENDS   = bootstrap zlib

LIBPNG_CONF_OPTS = \
	--disable-mips-msa \
	--disable-powerpc-vsx

LIBPNG_CONFIG_SCRIPTS = libpng$(LIBPNG_VERSION_X)-config

libpng:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_CONFIG_SCRIPTS)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
