################################################################################
#
# libexif
#
################################################################################

LIBEXIF_VERSION = 0.6.24
LIBEXIF_DIR = libexif-$(LIBEXIF_VERSION)
LIBEXIF_SOURCE = libexif-$(LIBEXIF_VERSION).tar.bz2
LIBEXIF_SITE = https://github.com/libexif/libexif/releases/download/v$(LIBEXIF_VERSION)

LIBEXIF_DEPENDS = bootstrap

LIBEXIF_AUTORECONF = YES

$(D)/libexif:
	$(call autotools-package)
