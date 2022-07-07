################################################################################
#
# host-mtd-utils
#
################################################################################

HOST_MTD_UTILS_VERSION = $(MTD_UTILS_VERSION)
HOST_MTD_UTILS_DIR = mtd-utils-$(HOST_MTD_UTILS_VERSION)
HOST_MTD_UTILS_SOURCE = mtd-utils-$(HOST_MTD_UTILS_VERSION).tar.bz2
HOST_MTD_UTILS_SITE = ftp://ftp.infradead.org/pub/mtd-utils

HOST_MTD_UTILS_DEPENDS = bootstrap

$(D)/host-mtd-utils:
HOST_MTD_UTILS_CONF_ENV = \
	ZLIB_CFLAGS=" " \
	ZLIB_LIBS="-lz" \
	UUID_CFLAGS=" " \
	UUID_LIBS="-luuid"

HOST_MTD_UTILS_CONF_OPTS = \
	--without-ubifs \
	--without-xattr \
	--disable-tests

$(D)/host-mtd-utils:
	$(call host-autotools-package)
