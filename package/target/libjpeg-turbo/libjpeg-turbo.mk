#
# libjpeg-turbo
#
LIBJPEG_TURBO_VER    = 2.0.4
LIBJPEG_TURBO_DIR    = libjpeg-turbo-$(LIBJPEG_TURBO_VER)
LIBJPEG_TURBO_SOURCE = libjpeg-turbo-$(LIBJPEG_TURBO_VER).tar.gz
LIBJPEG_TURBO_URL    = https://sourceforge.net/projects/libjpeg-turbo/files/$(LIBJPEG_TURBO_VER)

LIBJPEG_TURBO_PATCH  = \
	0001-tiff-ojpeg.patch

$(D)/libjpeg-turbo: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CMAKE) \
			-DWITH_SIMD=False \
			-DWITH_JPEG8=80 \
			| tail -n +90 \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,cjpeg djpeg jpegtran rdjpgcom tjbench wrjpgcom)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
