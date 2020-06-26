#
# bash
#
BASH_VER    = 5.0
BASH_DIR    = bash-$(BASH_VER)
BASH_SOURCE = bash-$(BASH_VER).tar.gz
BASH_SITE   = http://ftp.gnu.org/gnu/bash

BASH_PATCH = \
	bash50-001 \
	bash50-002 \
	bash50-003 \
	bash50-004 \
	bash50-005 \
	bash50-006 \
	bash50-007 \
	bash50-008 \
	bash50-009 \
	bash50-010 \
	bash50-011 \
	bash50-012 \
	bash50-013 \
	bash50-014 \
	bash50-015 \
	bash50-016 \
	bash50-017

$(D)/bash: bootstrap ncurses
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH), 0); \
		$(CONFIGURE); \
		$(MAKE); \
		$(INSTALL_EXEC) bash $(TARGET_DIR)/bin
	$(PKG_REMOVE)
	$(TOUCH)
