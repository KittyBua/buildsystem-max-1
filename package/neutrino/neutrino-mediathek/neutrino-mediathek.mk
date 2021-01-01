#
# neutrino-mediathek
#
NEUTRINO_MEDIATHEK_VER    = git
NEUTRINO_MEDIATHEK_DIR    = mediathek.git
NEUTRINO_MEDIATHEK_SOURCE = mediathek.git
NEUTRINO_MEDIATHEK_SITE   = https://github.com/neutrino-mediathek

$(D)/neutrino-mediathek: bootstrap | $(SHARE_PLUGINS)
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		cp -a plugins/* $(SHARE_PLUGINS); \
		cp -a share $(TARGET_DIR)/usr/
	$(PKG_REMOVE)
	$(TOUCH)
