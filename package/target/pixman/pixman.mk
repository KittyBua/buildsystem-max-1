#
# pixman
#
PIXMAN_VER    = 0.34.0
PIXMAN_DIR    = pixman-$(PIXMAN_VER)
PIXMAN_SOURCE = pixman-$(PIXMAN_VER).tar.gz
PIXMAN_SITE   = https://www.cairographics.org/releases
PIXMAN_DEPS   = bootstrap zlib libpng

PIXMAN_CONF_OPTS = \
	--disable-gtk \
	--disable-arm-simd \
	--disable-loongson-mmi \
	--disable-docs

$(D)/pixman:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
