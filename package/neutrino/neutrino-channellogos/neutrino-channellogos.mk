#
# fred_feuerstein's channellogos
#
NEUTRINO_CHANNELLOGOS_VER    = git
NEUTRINO_CHANNELLOGOS_DIR    = ni-logo-stuff.git
NEUTRINO_CHANNELLOGOS_SOURCE = ni-logo-stuff.git
NEUTRINO_CHANNELLOGOS_SITE   = https://github.com/neutrino-images

$(D)/neutrino-channellogos: bootstrap | $(SHARE_ICONS) $(SHARE_PLUGINS)
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_CPDIR)
	rm -rf $(SHARE_ICONS)/logo
	mkdir -p $(SHARE_ICONS)/logo
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/logos/* $(SHARE_ICONS)/logo
	mkdir -p $(SHARE_ICONS)/logo/events
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/logos-events/* $(SHARE_ICONS)/logo/events
	$(PKG_CHDIR)/logo-links && \
		./logo-linker.sh logo-links.db $(SHARE_ICONS)/logo
	cp -a $(PKG_BUILD_DIR)/logo-addon/* $(SHARE_PLUGINS)
	$(PKG_REMOVE)
	$(TOUCH)
