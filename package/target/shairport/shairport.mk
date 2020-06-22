#
# shairport
#
SHAIRPORT_VER      = git
SHAIRPORT_DIR      = shairport.git
SHAIRPORT_SOURCE   = shairport.git
SHAIRPORT_SITE     = https://github.com/abrasive
SHAIRPORT_CHECKOUT = 1.0-dev

$(D)/shairport: bootstrap openssl howl alsa-lib
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_CPDIR)
	$(PKG_CHDIR); \
		git checkout -q $(SHAIRPORT_CHECKOUT); \
		$(BUILD_ENV) \
		$(MAKE); \
		$(MAKE) install PREFIX=$(TARGET_DIR)/usr
	$(PKG_REMOVE)
	$(TOUCH)
