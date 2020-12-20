#
# bash
#
BASH_VER    = 5.0
BASH_DIR    = bash-$(BASH_VER)
BASH_SOURCE = bash-$(BASH_VER).tar.gz
BASH_SITE   = http://ftp.gnu.org/gnu/bash

BASH_PATCH = \
	0001-bash50-001.patch \
	0002-bash50-002.patch \
	0003-bash50-003.patch \
	0004-bash50-004.patch \
	0005-bash50-005.patch \
	0006-bash50-006.patch \
	0007-bash50-007.patch \
	0008-bash50-008.patch \
	0009-bash50-009.patch \
	0010-bash50-010.patch \
	0011-bash50-011.patch \
	0012-bash50-012.patch \
	0013-bash50-013.patch \
	0014-bash50-014.patch \
	0015-bash50-015.patch \
	0016-bash50-016.patch \
	0017-input.h-add-missing-include-on-stdio.h.patch \
	0018-locale.c-fix-build-without-wchar.patch

$(D)/bash: bootstrap ncurses
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches,$(PKG_PATCH)); \
		$(CONFIGURE); \
		$(MAKE); \
		$(INSTALL_EXEC) bash $(TARGET_DIR)/$(base_bindir)
	$(PKG_REMOVE)
	$(TOUCH)
