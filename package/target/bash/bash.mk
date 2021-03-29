#
# bash
#
BASH_VERSION = 5.0
BASH_DIR     = bash-$(BASH_VERSION)
BASH_SOURCE  = bash-$(BASH_VERSION).tar.gz
BASH_SITE    = http://ftp.gnu.org/gnu/bash
BASH_DEPENDS = bootstrap ncurses

bash:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(INSTALL_EXEC) bash $(TARGET_DIR)/$(base_bindir)
	$(REMOVE)
	$(TOUCH)
