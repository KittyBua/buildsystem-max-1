################################################################################
#
# neutrino-iptvplayer
#
################################################################################

NEUTRINO_IPTVPLAYER_VERSION = git
NEUTRINO_IPTVPLAYER_DIR = iptvplayer.git
NEUTRINO_IPTVPLAYER_SOURCE = iptvplayer.git
NEUTRINO_IPTVPLAYER_SITE = https://github.com/TangoCash

NEUTRINO_IPTVPLAYER_DEPENDS = rtmpdump python-twisted $(SHARE_NEUTRINO_PLUGINS)

$(D)/neutrino-iptvplayer-nightly \
$(D)/neutrino-iptvplayer: | bootstrap
	$(call PREPARE)
	@if [ "$@" = "$(D)/neutrino-iptvplayer-nightly" ]; then \
		$(BUILD_DIR)/iptvplayer/SyncWithGitLab.sh $(BUILD_DIR)/iptvplayer; \
	fi
	mkdir -p $(TARGET_SHARE_DIR)/E2emulator
	cp -R $(PKG_BUILD_DIR)/E2emulator/* $(TARGET_SHARE_DIR)/E2emulator/
	mkdir -p $(TARGET_SHARE_DIR)/E2emulator/Plugins/Extensions/IPTVPlayer
	cp -R $(PKG_BUILD_DIR)/IPTVplayer/* $(TARGET_SHARE_DIR)/E2emulator/Plugins/Extensions/IPTVPlayer/
	cp -R $(PKG_BUILD_DIR)/IPTVdaemon/* $(TARGET_SHARE_DIR)/E2emulator/Plugins/Extensions/IPTVPlayer/
	chmod 755 $(TARGET_SHARE_DIR)/E2emulator/Plugins/Extensions/IPTVPlayer/cmdlineIPTV.*
	chmod 755 $(TARGET_SHARE_DIR)/E2emulator/Plugins/Extensions/IPTVPlayer/IPTVdaemon.*
	PYTHONPATH=$(TARGET_DIR)/$(basename $(PYTHON_VERSION)) \
	$(HOST_DIR)/bin/python$(basename $(PYTHON_VERSION)) -Wi -t -O $(TARGET_DIR)/$(PYTHON_LIB_DIR)/compileall.py -q \
		-d /usr/share/E2emulator -f -x badsyntax $(TARGET_SHARE_DIR)/E2emulator
	cp -R $(PKG_BUILD_DIR)/addon4neutrino/neutrinoIPTV/* $(SHARE_NEUTRINO_PLUGINS)
	$(call TARGET_FOLLOWUP)
