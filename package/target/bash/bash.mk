#
# bash
#
BASH_VER    = 5.0
BASH_DIR    = bash-$(BASH_VER)
BASH_SOURCE = bash-$(BASH_VER).tar.gz
BASH_URL    = http://ftp.gnu.org/gnu/bash

$(D)/bash: bootstrap ncurses
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCHES_DIR), 0); \
		$(CONFIGURE); \
		$(MAKE); \
		$(INSTALL_EXEC) bash $(TARGET_DIR)/bin
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
