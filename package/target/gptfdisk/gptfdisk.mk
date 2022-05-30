################################################################################
#
# gptfdisk
#
################################################################################

GPTFDISK_VERSION = 1.0.9
GPTFDISK_DIR     = gptfdisk-$(GPTFDISK_VERSION)
GPTFDISK_SOURCE  = gptfdisk-$(GPTFDISK_VERSION).tar.gz
GPTFDISK_SITE    = https://sourceforge.net/projects/gptfdisk/files/gptfdisk/$(GPTFDISK_VERSION)
GPTFDISK_DEPENDS = bootstrap e2fsprogs ncurses popt

$(D)/gptfdisk:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_CONFIGURE_ENV) \
		$(MAKE) sgdisk; \
		$(INSTALL_EXEC) sgdisk $(TARGET_SBIN_DIR)/sgdisk
	$(call TARGET_FOLLOWUP)
