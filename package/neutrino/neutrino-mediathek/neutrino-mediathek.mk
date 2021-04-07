#
# neutrino-mediathek
#
NEUTRINO_MEDIATHEK_VERSION = git
NEUTRINO_MEDIATHEK_DIR     = mediathek.git
NEUTRINO_MEDIATHEK_SOURCE  = mediathek.git
NEUTRINO_MEDIATHEK_SITE    = https://github.com/neutrino-mediathek
NEUTRINO_MEDIATHEK_DEPENDS = bootstrap $(SHARE_PLUGINS)

$(D)/neutrino-mediathek:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		cp -a plugins/* $(SHARE_PLUGINS); \
		cp -a share $(TARGET_DIR)/usr/
	$(REMOVE)
	$(TOUCH)
