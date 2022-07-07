################################################################################
#
# libdvbsi
#
################################################################################

LIBDVBSI_VERSION = git
LIBDVBSI_DIR = libdvbsi.git
LIBDVBSI_SOURCE = libdvbsi.git
LIBDVBSI_SITE = https://github.com/OpenVisionE2

LIBDVBSI_DEPENDS = bootstrap

LIBDVBSI_CONF_OPTS = \
	--enable-shared \
	--disable-static

$(D)/libdvbsi:
	$(call autotools-package)
