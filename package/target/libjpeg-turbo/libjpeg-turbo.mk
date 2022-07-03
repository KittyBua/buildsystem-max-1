################################################################################
#
# libjpeg-turbo
#
################################################################################

LIBJPEG_TURBO_VERSION = 2.1.3
LIBJPEG_TURBO_DIR     = libjpeg-turbo-$(LIBJPEG_TURBO_VERSION)
LIBJPEG_TURBO_SOURCE  = libjpeg-turbo-$(LIBJPEG_TURBO_VERSION).tar.gz
LIBJPEG_TURBO_SITE    = https://sourceforge.net/projects/libjpeg-turbo/files/$(LIBJPEG_TURBO_VERSION)
LIBJPEG_TURBO_DEPENDS = bootstrap

LIBJPEG_TURBO_CONF_OPTS = \
	-DCMAKE_INSTALL_BINDIR="$(REMOVE_bindir)" \
	-DWITH_SIMD=False \
	-DWITH_JPEG8=80

$(D)/libjpeg-turbo:
	$(call cmake-package)
