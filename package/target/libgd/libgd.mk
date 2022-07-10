################################################################################
#
# libgd
#
################################################################################

LIBGD_VERSION = 2.3.3
LIBGD_DIR = libgd-$(LIBGD_VERSION)
LIBGD_SOURCE = libgd-$(LIBGD_VERSION).tar.xz
LIBGD_SITE = https://github.com/libgd/libgd/releases/download/gd-$(LIBGD_VERSION)

LIBGD_DEPENDS = zlib libpng libjpeg-turbo freetype

LIBGD_CONF_OPTS = \
	--bindir=$(REMOVE_bindir) \
	--without-fontconfig \
	--without-xpm \
	--without-x

$(D)/libgd: | bootstrap
	$(call autotools-package)
