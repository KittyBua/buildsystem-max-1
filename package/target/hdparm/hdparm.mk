#
# hdparm
#
HDPARM_VER    = 9.60
HDPARM_DIR    = hdparm-$(HDPARM_VER)
HDPARM_SOURCE = hdparm-$(HDPARM_VER).tar.gz
HDPARM_SITE   = https://sourceforge.net/projects/hdparm/files/hdparm
HDPARM_DEPS   = bootstrap

$(D)/hdparm:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(TARGET_CONFIGURE_ENV) \
		$(MAKE) CROSS=$(TARGET_CROSS); \
		$(MAKE) install DESTDIR=$(TARGET_DIR) mandir=$(REMOVE_mandir)
	$(PKG_REMOVE)
	$(TOUCH)
