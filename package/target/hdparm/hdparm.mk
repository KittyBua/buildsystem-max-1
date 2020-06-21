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
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(BUILD_ENV) \
		$(MAKE) CROSS=$(TARGET_CROSS) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR) mandir=/.remove
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
