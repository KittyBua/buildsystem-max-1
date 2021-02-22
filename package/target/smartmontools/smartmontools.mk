#
# smartmontools
#
SMARTMONTOOLS_VER    = 7.2
SMARTMONTOOLS_DIR    = smartmontools-$(SMARTMONTOOLS_VER)
SMARTMONTOOLS_SOURCE = smartmontools-$(SMARTMONTOOLS_VER).tar.gz
SMARTMONTOOLS_SITE   = https://sourceforge.net/projects/smartmontools/files/smartmontools/$(SMARTMONTOOLS_VER)
SMARTMONTOOLS_DEPS   = bootstrap

$(D)/smartmontools:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(INSTALL_EXEC) smartctl $(TARGET_DIR)/usr/sbin/smartctl
	$(REMOVE)
	$(TOUCH)
