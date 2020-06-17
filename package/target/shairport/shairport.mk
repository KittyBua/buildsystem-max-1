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
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(CPDIR)/$(PKG_DIR)
	$(CHDIR)/$(PKG_DIR); \
		git checkout -q $(SHAIRPORT_CHECKOUT); \
		$(BUILD_ENV) \
		$(MAKE); \
		$(MAKE) install PREFIX=$(TARGET_DIR)/usr
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
