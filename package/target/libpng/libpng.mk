#
# libpng
#
LIBPNG_VER    = 1.6.37
LIBPNG_VER_X  = 16
LIBPNG_DIR    = libpng-$(LIBPNG_VER)
LIBPNG_SOURCE = libpng-$(LIBPNG_VER).tar.xz
LIBPNG_SITE   = https://sourceforge.net/projects/libpng/files/libpng$(LIBPNG_VER_X)/$(LIBPNG_VER)
LIBPNG_DEPS   = bootstrap zlib

LIBPNG_CONF_OPTS = \
	--disable-mips-msa \
	--disable-powerpc-vsx

LIBPNG_CONFIG_SCRIPTS = libpng$(LIBPNG_VER_X)-config

$(D)/libpng:
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
