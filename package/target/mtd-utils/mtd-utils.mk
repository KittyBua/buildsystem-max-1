#
# mtd-utils
#
MTD_UTILS_VER    = 1.5.2
MTD_UTILS_DIR    = mtd-utils-$(MTD_UTILS_VER)
MTD_UTILS_SOURCE = mtd-utils-$(MTD_UTILS_VER).tar.bz2
MTD_UTILS_SITE   = ftp://ftp.infradead.org/pub/mtd-utils

MTD_UTILS_PATCH  = \
	0002-mtd-utils-sysmacros.patch

$(D)/mtd-utils: bootstrap zlib lzo e2fsprogs
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(BUILD_ENV) \
		$(MAKE) PREFIX= CC=$(TARGET_CC) LD=$(TARGET_LD) STRIP=$(TARGET_STRIP) WITHOUT_XATTR=1 DESTDIR=$(TARGET_DIR); \
		cp -a $(BUILD_DIR)/mtd-utils-$(MTD_UTILS_VER)/mkfs.jffs2 $(TARGET_DIR)/usr/sbin
		cp -a $(BUILD_DIR)/mtd-utils-$(MTD_UTILS_VER)/sumtool $(TARGET_DIR)/usr/sbin
	$(PKG_REMOVE)
	$(TOUCH)
