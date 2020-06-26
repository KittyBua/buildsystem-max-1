#
# hdparm
#
HDPARM_VER    = 9.58
HDPARM_DIR    = hdparm-$(HDPARM_VER)
HDPARM_SOURCE = hdparm-$(HDPARM_VER).tar.gz
HDPARM_SITE   = https://sourceforge.net/projects/hdparm/files/hdparm

$(D)/hdparm: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(BUILD_ENV) \
		$(MAKE) CROSS=$(TARGET_CROSS) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR) mandir=/.remove
	$(PKG_REMOVE)
	$(TOUCH)
