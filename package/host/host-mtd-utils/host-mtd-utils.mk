#
# host-mtd-utils
#
HOST_MTD_UTILS_VER    = 1.5.2
HOST_MTD_UTILS_DIR    = mtd-utils-$(HOST_MTD_UTILS_VER)
HOST_MTD_UTILS_SOURCE = mtd-utils-$(HOST_MTD_UTILS_VER).tar.bz2
HOST_MTD_UTILS_URL    = ftp://ftp.infradead.org/pub/mtd-utils

HOST_MTD_UTILS_PATCH  = \
	0001-mtd-utils.patch \
	0002-mtd-utils-sysmacros.patch

$(D)/host-mtd-utils: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(MAKE) `pwd`/mkfs.jffs2 `pwd`/sumtool BUILDDIR=`pwd` WITHOUT_XATTR=1 DESTDIR=$(HOST_DIR); \
		$(MAKE) install DESTDIR=$(HOST_DIR)/bin
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
