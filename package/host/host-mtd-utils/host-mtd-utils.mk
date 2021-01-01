#
# host-mtd-utils
#
HOST_MTD_UTILS_VER    = 1.5.2
HOST_MTD_UTILS_DIR    = mtd-utils-$(HOST_MTD_UTILS_VER)
HOST_MTD_UTILS_SOURCE = mtd-utils-$(HOST_MTD_UTILS_VER).tar.bz2
HOST_MTD_UTILS_SITE   = ftp://ftp.infradead.org/pub/mtd-utils

$(D)/host-mtd-utils: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(MAKE) `pwd`/mkfs.jffs2 `pwd`/sumtool BUILDDIR=`pwd` WITHOUT_XATTR=1 DESTDIR=$(HOST_DIR); \
		$(MAKE) install DESTDIR=$(HOST_DIR)/bin
	$(PKG_REMOVE)
	$(TOUCH)
