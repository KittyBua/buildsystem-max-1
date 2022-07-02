################################################################################
#
# jpeg
#
################################################################################

JPEG_VERSION = 8d
JPEG_DIR     = jpeg-$(JPEG_VERSION)
JPEG_SOURCE  = jpegsrc.v$(JPEG_VERSION).tar.gz
JPEG_SITE    = http://www.ijg.org/files
JPEG_DEPENDS = bootstrap

define JPEG_CLEANUP_TARGET
	rm -f $(addprefix $(TARGET_BIN_DIR)/,cjpeg djpeg jpegtran rdjpgcom wrjpgcom)
endef
JPEG_CLEANUP_TARGET_HOOKS += JPEG_CLEANUP_TARGET

$(D)/jpeg:
	$(call autotools-package)
