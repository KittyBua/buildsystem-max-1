#
# libjpeg-turbo
#
LIBJPEG_TURBO_VER    = 2.0.6
LIBJPEG_TURBO_DIR    = libjpeg-turbo-$(LIBJPEG_TURBO_VER)
LIBJPEG_TURBO_SOURCE = libjpeg-turbo-$(LIBJPEG_TURBO_VER).tar.gz
LIBJPEG_TURBO_SITE   = https://sourceforge.net/projects/libjpeg-turbo/files/$(LIBJPEG_TURBO_VER)

LIBJPEG_TURBO_PATCH  = \
	0001-tiff-ojpeg.patch

$(D)/libjpeg-turbo: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CMAKE) \
			-DWITH_SIMD=False \
			-DWITH_JPEG8=80 \
			| tail -n +90 \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,cjpeg djpeg jpegtran rdjpgcom tjbench wrjpgcom)
	$(PKG_REMOVE)
	$(TOUCH)
