################################################################################
#
# host-mtd-utils
#
################################################################################

HOST_MTD_UTILS_VERSION = 1.5.2
HOST_MTD_UTILS_DIR     = mtd-utils-$(HOST_MTD_UTILS_VERSION)
HOST_MTD_UTILS_SOURCE  = mtd-utils-$(HOST_MTD_UTILS_VERSION).tar.bz2
HOST_MTD_UTILS_SITE    = ftp://ftp.infradead.org/pub/mtd-utils
HOST_MTD_UTILS_DEPENDS = bootstrap

$(D)/host-mtd-utils:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) `pwd`/mkfs.jffs2 `pwd`/sumtool BUILDDIR=`pwd` WITHOUT_XATTR=1 DESTDIR=$(HOST_DIR); \
		$(MAKE) install DESTDIR=$(HOST_DIR)/bin
	$(call TARGET_FOLLOWUP)
