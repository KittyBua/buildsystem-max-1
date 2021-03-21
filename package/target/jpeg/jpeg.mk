#
# jpeg
#
JPEG_VERSION = 8d
JPEG_DIR     = jpeg-$(JPEG_VERSION)
JPEG_SOURCE  = jpegsrc.v$(JPEG_VERSION).tar.gz
JPEG_SITE    = http://www.ijg.org/files
JPEG_DEPENDS = bootstrap

$(D)/jpeg:
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
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,cjpeg djpeg jpegtran rdjpgcom wrjpgcom)
	$(TOUCH)
