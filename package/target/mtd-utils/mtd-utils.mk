################################################################################
#
# mtd-utils
#
################################################################################

MTD_UTILS_VERSION = 2.1.2
MTD_UTILS_DIR = mtd-utils-$(MTD_UTILS_VERSION)
MTD_UTILS_SOURCE = mtd-utils-$(MTD_UTILS_VERSION).tar.bz2
MTD_UTILS_SITE = https://infraroot.at/pub/mtd

TD_UTILS_DEPENDS = bootstrap zlib lzo e2fsprogs

MTD_UTILS_CONF_OPTS = \
	--disable-tests \
	--without-zstd \
	--without-ubifs \
	--without-xattr

$(D)/mtd-utils:
	$(call autotools-package)
