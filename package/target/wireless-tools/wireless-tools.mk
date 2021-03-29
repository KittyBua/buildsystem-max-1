#
# wireless-tools
#
WIRELESS_TOOLS_VERSION = 30
WIRELESS_TOOLS_DIR     = wireless_tools.$(WIRELESS_TOOLS_VERSION)
WIRELESS_TOOLS_SOURCE  = wireless_tools.$(WIRELESS_TOOLS_VERSION).pre9.tar.gz
WIRELESS_TOOLS_SITE    = https://hewlettpackard.github.io/wireless-tools
WIRELESS_TOOLS_DEPENDS = bootstrap

wireless-tools:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(MAKE) CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS) -I."; \
		$(MAKE) install PREFIX=$(TARGET_DIR)/usr INSTALL_MAN=$(TARGET_DIR)$(REMOVE_mandir)
	$(REMOVE)
	$(TOUCH)
