#
# wireless-tools
#
WIRELESS_TOOLS_VER    = 30
WIRELESS_TOOLS_DIR    = wireless_tools.$(WIRELESS_TOOLS_VER)
WIRELESS_TOOLS_SOURCE = wireless_tools.$(WIRELESS_TOOLS_VER).pre9.tar.gz
WIRELESS_TOOLS_SITE   = https://hewlettpackard.github.io/wireless-tools
WIRELESS_TOOLS_DEPS   = bootstrap

$(D)/wireless-tools:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(MAKE) CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS) -I."; \
		$(MAKE) install PREFIX=$(TARGET_DIR)/usr INSTALL_MAN=$(TARGET_DIR)$(REMOVE_mandir)
	$(REMOVE)
	$(TOUCH)
