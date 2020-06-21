#
# smartmontools
#
SMARTMONTOOLS_VER    = 7.1
SMARTMONTOOLS_DIR    = smartmontools-$(SMARTMONTOOLS_VER)
SMARTMONTOOLS_SOURCE = smartmontools-$(SMARTMONTOOLS_VER).tar.gz
SMARTMONTOOLS_SITE   = https://sourceforge.net/projects/smartmontools/files/smartmontools/$(SMARTMONTOOLS_VER)

$(D)/smartmontools: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			; \
		$(MAKE); \
		$(INSTALL_EXEC) smartctl $(TARGET_DIR)/usr/sbin/smartctl
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
