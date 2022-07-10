################################################################################
#
# neutrino-mediathek
#
################################################################################

NEUTRINO_MEDIATHEK_VERSION = git
NEUTRINO_MEDIATHEK_DIR = mediathek.git
NEUTRINO_MEDIATHEK_SOURCE = mediathek.git
NEUTRINO_MEDIATHEK_SITE = https://github.com/neutrino-mediathek
NEUTRINO_MEDIATHEK_DEPENDS = $(SHARE_NEUTRINO_PLUGINS)

$(D)/neutrino-mediathek: | bootstrap
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		cp -a plugins/* $(SHARE_NEUTRINO_PLUGINS); \
		cp -a share $(TARGET_DIR)/usr/
	$(call TARGET_FOLLOWUP)
