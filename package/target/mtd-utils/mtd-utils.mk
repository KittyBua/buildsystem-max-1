#
# mtd-utils
#
MTD_UTILS_VERSION = 1.5.2
MTD_UTILS_DIR     = mtd-utils-$(MTD_UTILS_VERSION)
MTD_UTILS_SOURCE  = mtd-utils-$(MTD_UTILS_VERSION).tar.bz2
MTD_UTILS_SITE    = https://infraroot.at/pub/mtd
MTD_UTILS_DEPENDS = bootstrap zlib lzo e2fsprogs

$(D)/mtd-utils:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(TARGET_CONFIGURE_OPTS) \
		$(MAKE) PREFIX= CC=$(TARGET_CC) LD=$(TARGET_LD) STRIP=$(TARGET_STRIP) WITHOUT_XATTR=1 DESTDIR=$(TARGET_DIR); \
		cp -a $(BUILD_DIR)/mtd-utils-$(MTD_UTILS_VERSION)/mkfs.jffs2 $(TARGET_DIR)/usr/sbin
		cp -a $(BUILD_DIR)/mtd-utils-$(MTD_UTILS_VERSION)/sumtool $(TARGET_DIR)/usr/sbin
	$(REMOVE)
	$(TOUCH)
