#
# mtd-utils
#
MTD_UTILS_VER    = 1.5.2
MTD_UTILS_DIR    = mtd-utils-$(MTD_UTILS_VER)
MTD_UTILS_SOURCE = mtd-utils-$(MTD_UTILS_VER).tar.bz2
MTD_UTILS_SITE   = https://infraroot.at/pub/mtd
MTD_UTILS_DEPS   = bootstrap zlib lzo e2fsprogs

$(D)/mtd-utils:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(TARGET_CONFIGURE_ENV) \
		$(MAKE) PREFIX= CC=$(TARGET_CC) LD=$(TARGET_LD) STRIP=$(TARGET_STRIP) WITHOUT_XATTR=1 DESTDIR=$(TARGET_DIR); \
		cp -a $(BUILD_DIR)/mtd-utils-$(MTD_UTILS_VER)/mkfs.jffs2 $(TARGET_DIR)/usr/sbin
		cp -a $(BUILD_DIR)/mtd-utils-$(MTD_UTILS_VER)/sumtool $(TARGET_DIR)/usr/sbin
	$(REMOVE)
	$(TOUCH)
