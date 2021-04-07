#
# smartmontools
#
SMARTMONTOOLS_VERSION = 7.2
SMARTMONTOOLS_DIR     = smartmontools-$(SMARTMONTOOLS_VERSION)
SMARTMONTOOLS_SOURCE  = smartmontools-$(SMARTMONTOOLS_VERSION).tar.gz
SMARTMONTOOLS_SITE    = https://sourceforge.net/projects/smartmontools/files/smartmontools/$(SMARTMONTOOLS_VERSION)
SMARTMONTOOLS_DEPENDS = bootstrap

$(D)/smartmontools:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(INSTALL_EXEC) smartctl $(TARGET_DIR)/usr/sbin/smartctl
	$(REMOVE)
	$(TOUCH)
