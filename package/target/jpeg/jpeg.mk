################################################################################
#
# jpeg
#
################################################################################

JPEG_VERSION = 8d
JPEG_DIR = jpeg-$(JPEG_VERSION)
JPEG_SOURCE = jpegsrc.v$(JPEG_VERSION).tar.gz
JPEG_SITE = http://www.ijg.org/files

JPEG_DEPENDS = bootstrap

define JPEG_TARGET_CLEANUP
	rm -f $(addprefix $(TARGET_BIN_DIR)/,cjpeg djpeg jpegtran rdjpgcom wrjpgcom)
endef
JPEG_TARGET_CLEANUP_HOOKS += JPEG_TARGET_CLEANUP

$(D)/jpeg:
	$(call autotools-package)
