################################################################################
#
# libvorbis
#
################################################################################

LIBVORBIS_VERSION = 1.3.7
LIBVORBIS_DIR     = libvorbis-$(LIBVORBIS_VERSION)
LIBVORBIS_SOURCE  = libvorbis-$(LIBVORBIS_VERSION).tar.xz
LIBVORBIS_SITE    = https://ftp.osuosl.org/pub/xiph/releases/vorbis
LIBVORBIS_DEPENDS = bootstrap libogg

LIBVORBIS_AUTORECONF = YES

LIBVORBIS_CONF_OPTS = \
	--disable-docs \
	--disable-examples \
	--disable-oggtest

$(D)/libvorbis:
	$(call make-package)
