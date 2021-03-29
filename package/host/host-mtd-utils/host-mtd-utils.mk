#
# host-mtd-utils
#
HOST_MTD_UTILS_VERSION = 1.5.2
HOST_MTD_UTILS_DIR     = mtd-utils-$(HOST_MTD_UTILS_VERSION)
HOST_MTD_UTILS_SOURCE  = mtd-utils-$(HOST_MTD_UTILS_VERSION).tar.bz2
HOST_MTD_UTILS_SITE    = ftp://ftp.infradead.org/pub/mtd-utils
HOST_MTD_UTILS_DEPENDS = bootstrap

host-mtd-utils:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(MAKE) `pwd`/mkfs.jffs2 `pwd`/sumtool BUILDDIR=`pwd` WITHOUT_XATTR=1 DESTDIR=$(HOST_DIR); \
		$(MAKE) install DESTDIR=$(HOST_DIR)/bin
	$(REMOVE)
	$(TOUCH)
