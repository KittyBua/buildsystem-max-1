#
# neutrino-mediathek
#
NEUTRINO_MEDIATHEK_VER    = git
NEUTRINO_MEDIATHEK_DIR    = mediathek.git
NEUTRINO_MEDIATHEK_SOURCE = mediathek.git
NEUTRINO_MEDIATHEK_SITE   = https://github.com/neutrino-mediathek

NEUTRINO_MEDIATHEK_PATCH  = \
	neutrino-mediathek.patch

$(D)/neutrino-mediathek: bootstrap | $(SHARE_PLUGINS)
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		cp -a plugins/* $(SHARE_PLUGINS); \
		cp -a share $(TARGET_DIR)/usr/
	$(PKG_REMOVE)
	$(TOUCH)
