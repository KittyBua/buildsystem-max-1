#
# pixman
#
PIXMAN_VER    = 0.34.0
PIXMAN_DIR    = pixman-$(PIXMAN_VER)
PIXMAN_SOURCE = pixman-$(PIXMAN_VER).tar.gz
PIXMAN_URL    = https://www.cairographics.org/releases

PIXMAN_PATCH  = \
	0001-ARM-qemu-related-workarounds-in-cpu-features-detecti.patch \
	0002-test-utils-Check-for-FE_INVALID-definition-before-us.patch \
	0003-asm_include.patch

$(D)/pixman: bootstrap zlib libpng
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--disable-gtk \
			--disable-arm-simd \
			--disable-loongson-mmi \
			--disable-docs \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
