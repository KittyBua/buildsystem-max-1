#
# gptfdisk
#
GPTFDISK_VER    = 1.0.5
GPTFDISK_DIR    = gptfdisk-$(GPTFDISK_VER)
GPTFDISK_SOURCE = gptfdisk-$(GPTFDISK_VER).tar.gz
GPTFDISK_SITE   = https://sourceforge.net/projects/gptfdisk/files/gptfdisk/$(GPTFDISK_VER)

$(D)/gptfdisk: bootstrap e2fsprogs ncurses popt
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(BUILD_ENV) \
		$(MAKE) sgdisk; \
		$(INSTALL_EXEC) sgdisk $(TARGET_DIR)/usr/sbin/sgdisk
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
