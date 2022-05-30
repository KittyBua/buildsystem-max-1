################################################################################
#
# smartmontools
#
################################################################################

SMARTMONTOOLS_VERSION = 7.2
SMARTMONTOOLS_DIR     = smartmontools-$(SMARTMONTOOLS_VERSION)
SMARTMONTOOLS_SOURCE  = smartmontools-$(SMARTMONTOOLS_VERSION).tar.gz
SMARTMONTOOLS_SITE    = https://sourceforge.net/projects/smartmontools/files/smartmontools/$(SMARTMONTOOLS_VERSION)
SMARTMONTOOLS_DEPENDS = bootstrap

$(D)/smartmontools:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(INSTALL_EXEC) smartctl $(TARGET_SBIN_DIR)/smartctl
	$(call TARGET_FOLLOWUP)
