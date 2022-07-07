################################################################################
#
# libpng
#
################################################################################

LIBPNG_VERSION = 1.6.37
LIBPNG_SERIES = 16
LIBPNG_DIR = libpng-$(LIBPNG_VERSION)
LIBPNG_SOURCE = libpng-$(LIBPNG_VERSION).tar.xz
LIBPNG_SITE = https://downloads.sourceforge.net/project/libpng/libpng$(LIBPNG_SERIES)/$(LIBPNG_VERSION)

LIBPNG_DEPENDS = bootstrap zlib

LIBPNG_CONFIG_SCRIPTS = libpng$(LIBPNG_SERIES)-config

LIBPNG_CONF_OPTS = \
	--disable-mips-msa \
	--disable-powerpc-vsx \
	$(if $(filter $(BOXMODEL),hd5x hd6x vusolo4k vuduo4k vuduo4kse vuultimo4k vuzero4k vuuno4k vuuno4kse),--enable-arm-neon,--disable-arm-neon)

define LIBPNG_TARGET_CLEANUP
	rm -f $(addprefix $(TARGET_BIN_DIR)/,libpng-config)
endef
LIBPNG_TARGET_CLEANUP_HOOKS += LIBPNG_TARGET_CLEANUP

$(D)/libpng:
	$(call autotools-package)
