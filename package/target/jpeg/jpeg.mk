#
# jpeg
#
JPEG_VER    = 8d
JPEG_DIR    = jpeg-$(JPEG_VER)
JPEG_SOURCE = jpegsrc.v$(JPEG_VER).tar.gz
JPEG_SITE   = http://www.ijg.org/files
JPEG_DEPS   = bootstrap

$(D)/jpeg:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,cjpeg djpeg jpegtran rdjpgcom wrjpgcom)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
