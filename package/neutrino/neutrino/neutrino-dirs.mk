################################################################################
#
# neutrino-dirs
#
################################################################################

SHARE_NEUTRINO_FLEX      = $(TARGET_SHARE_DIR)/tuxbox/neutrino/flex
SHARE_NEUTRINO_ICONS     = $(TARGET_SHARE_DIR)/tuxbox/neutrino/icons
SHARE_NEUTRINO_LCD4LINUX = $(TARGET_SHARE_DIR)/tuxbox/neutrino/lcd/icons
SHARE_NEUTRINO_LOGOS     = $(TARGET_SHARE_DIR)/tuxbox/neutrino/icons/logo
SHARE_NEUTRINO_PLUGINS   = $(TARGET_SHARE_DIR)/tuxbox/neutrino/plugins
SHARE_NEUTRINO_THEMES    = $(TARGET_SHARE_DIR)/tuxbox/neutrino/themes
SHARE_NEUTRINO_WEBRADIO  = $(TARGET_SHARE_DIR)/tuxbox/neutrino/webradio
SHARE_NEUTRINO_WEBTV     = $(TARGET_SHARE_DIR)/tuxbox/neutrino/webtv
VAR_NEUTRINO_CONFIG      = $(TARGET_DIR)/var/tuxbox/config
VAR_NEUTRINO_PLUGINS     = $(TARGET_DIR)/var/tuxbox/plugins

$(SHARE_NEUTRINO_FLEX) \
$(SHARE_NEUTRINO_ICONS) \
$(SHARE_NEUTRINO_LCD4LINUX) \
$(SHARE_NEUTRINO_LOGOS) \
$(SHARE_NEUTRINO_PLUGINS) \
$(SHARE_NEUTRINO_THEMES) \
$(SHARE_NEUTRINO_WEBRADIO) \
$(SHARE_NEUTRINO_WEBTV) \
$(VAR_NEUTRINO_CONFIG) \
$(VAR_NEUTRINO_PLUGINS): | $(TARGET_DIR)
	mkdir -p $(@)
