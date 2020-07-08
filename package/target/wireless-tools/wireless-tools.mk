#
# wireless-tools
#
WIRELESS_TOOLS_VER    = 30
WIRELESS_TOOLS_DIR    = wireless_tools.$(WIRELESS_TOOLS_VER)
WIRELESS_TOOLS_SOURCE = wireless_tools.$(WIRELESS_TOOLS_VER).pre9.tar.gz
WIRELESS_TOOLS_SITE   = https://hewlettpackard.github.io/wireless-tools

WIRELESS_TOOLS_PATCH  = \
	0001-remove-bzero.patch \
	0002-remove.ldconfig.call.patch \
	0003-avoid_strip.patch \
	0004-ldflags.patch

$(D)/wireless-tools: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(MAKE) CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS) -I."; \
		$(MAKE) install PREFIX=$(TARGET_DIR)/usr INSTALL_MAN=$(TARGET_DIR)/.remove
	$(PKG_REMOVE)
	$(TOUCH)
