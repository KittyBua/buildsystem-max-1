#
# neutrino-mediathek
#
NEUTRINO_MEDIATHEK_VER    = git
NEUTRINO_MEDIATHEK_DIR    = mediathek.git
NEUTRINO_MEDIATHEK_SOURCE = mediathek.git
NEUTRINO_MEDIATHEK_SITE   = https://github.com/neutrino-mediathek
NEUTRINO_MEDIATHEK_DEPS   = bootstrap $(SHARE_PLUGINS)

$(D)/neutrino-mediathek:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		cp -a plugins/* $(SHARE_PLUGINS); \
		cp -a share $(TARGET_DIR)/usr/
	$(REMOVE)
	$(TOUCH)
