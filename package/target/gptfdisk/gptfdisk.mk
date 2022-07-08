################################################################################
#
# gptfdisk
#
################################################################################

GPTFDISK_VERSION = 1.0.9
GPTFDISK_DIR = gptfdisk-$(GPTFDISK_VERSION)
GPTFDISK_SOURCE = gptfdisk-$(GPTFDISK_VERSION).tar.gz
GPTFDISK_SITE = https://sourceforge.net/projects/gptfdisk/files/gptfdisk/$(GPTFDISK_VERSION)

GPTFDISK_DEPENDS = bootstrap e2fsprogs ncurses popt

GPTFDISK_SBINARIES = sgdisk

GPTFDISK_MAKE_ENV = \
	$(TARGET_CONFIGURE_ENV)

GPTFDISK_MAKE_OPTS = \
	$(GPTFDISK_SBINARIES)

define GPTFDISK_INSTALL_BINARY
	$(INSTALL_EXEC) $(PKG_BUILD_DIR)/sgdisk $(TARGET_SBIN_DIR)/sgdisk
endef
GPTFDISK_POST_FOLLOWUP_HOOKS += GPTFDISK_INSTALL_BINARY

$(D)/gptfdisk:
	$(call generic-package,$(PKG_NO_INSTALL))
