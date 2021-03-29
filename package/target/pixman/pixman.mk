#
# pixman
#
PIXMAN_VERSION = 0.34.0
PIXMAN_DIR     = pixman-$(PIXMAN_VERSION)
PIXMAN_SOURCE  = pixman-$(PIXMAN_VERSION).tar.gz
PIXMAN_SITE    = https://www.cairographics.org/releases
PIXMAN_DEPENDS = bootstrap zlib libpng

PIXMAN_CONF_OPTS = \
	--disable-gtk \
	--disable-arm-simd \
	--disable-loongson-mmi

pixman:
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
