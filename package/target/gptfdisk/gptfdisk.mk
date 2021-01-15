#
# gptfdisk
#
GPTFDISK_VER    = 1.0.5
GPTFDISK_DIR    = gptfdisk-$(GPTFDISK_VER)
GPTFDISK_SOURCE = gptfdisk-$(GPTFDISK_VER).tar.gz
GPTFDISK_SITE   = https://sourceforge.net/projects/gptfdisk/files/gptfdisk/$(GPTFDISK_VER)
GPTFDISK_DEPS   = bootstrap e2fsprogs ncurses popt

$(D)/gptfdisk:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(BUILD_ENV) \
		$(MAKE) sgdisk; \
		$(INSTALL_EXEC) sgdisk $(TARGET_DIR)/usr/sbin/sgdisk
	$(PKG_REMOVE)
	$(TOUCH)
