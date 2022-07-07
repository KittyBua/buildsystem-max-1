################################################################################
#
# libmad
#
################################################################################

LIBMAD_VERSION = 0.15.1b
LIBMAD_DIR = libmad-$(LIBMAD_VERSION)
LIBMAD_SOURCE = libmad_$(LIBMAD_VERSION).orig.tar.gz
LIBMAD_SITE = http://snapshot.debian.org/archive/debian/20190310T213528Z/pool/main/libm/libmad

LIBMAD_DEPENDS = bootstrap

LIBMAD_AUTORECONF = YES

LIBMAD_CONF_OPTS = \
	--enable-shared=yes \
	--enable-accuracy \
	--enable-sso \
	--disable-debugging \
	$(if $(filter $(TARGET_ARCH),arm mips),--enable-fpm=$(TARGET_ARCH),--enable-fpm=64bit)

$(D)/libmad:
	$(call autotools-package)
