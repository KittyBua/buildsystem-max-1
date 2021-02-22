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

$(D)/libpng:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/bin/libpng*-config $(HOST_DIR)/bin/
	$(REWRITE_CONFIG) $(HOST_DIR)/bin/libpng$(LIBPNG_VER_X)-config
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
