#
# host-mtd-utils
#
HOST_MTD_UTILS_VER    = 1.5.2
HOST_MTD_UTILS_DIR    = mtd-utils-$(HOST_MTD_UTILS_VER)
HOST_MTD_UTILS_SOURCE = mtd-utils-$(HOST_MTD_UTILS_VER).tar.bz2
HOST_MTD_UTILS_SITE   = ftp://ftp.infradead.org/pub/mtd-utils
HOST_MTD_UTILS_DEPS   = bootstrap

$(D)/host-mtd-utils:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(MAKE) `pwd`/mkfs.jffs2 `pwd`/sumtool BUILDDIR=`pwd` WITHOUT_XATTR=1 DESTDIR=$(HOST_DIR); \
		$(MAKE) install DESTDIR=$(HOST_DIR)/bin
	$(REMOVE)
	$(TOUCH)
