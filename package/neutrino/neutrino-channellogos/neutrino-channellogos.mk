#
# fred_feuerstein's channellogos
#
NEUTRINO_CHANNELLOGOS_VER    = git
NEUTRINO_CHANNELLOGOS_DIR    = ni-logo-stuff.git
NEUTRINO_CHANNELLOGOS_SOURCE = ni-logo-stuff.git
NEUTRINO_CHANNELLOGOS_SITE   = https://github.com/neutrino-images
NEUTRINO_CHANNELLOGOS_DEPS   = bootstrap $(SHARE_ICONS) $(SHARE_PLUGINS)

$(D)/neutrino-channellogos:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	rm -rf $(SHARE_LOGOS)
	mkdir -p $(SHARE_LOGOS)
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/logos/* $(SHARE_LOGOS)
	mkdir -p $(SHARE_LOGOS)/events
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/logos-events/* $(SHARE_LOGOS)/events
	$(PKG_CHDIR)/logo-links && \
		./logo-linker.sh logo-links.db $(SHARE_LOGOS)
	cp -a $(PKG_BUILD_DIR)/logo-addon/* $(SHARE_PLUGINS)
	$(REMOVE)
	$(TOUCH)
