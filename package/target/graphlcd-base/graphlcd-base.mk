#
# graphlcd-base
#
GRAPHLCD_BASE_VER    = git
GRAPHLCD_BASE_DIR    = graphlcd-base.git
GRAPHLCD_BASE_SOURCE = graphlcd-base.git
GRAPHLCD_BASE_SITE   = git://projects.vdr-developer.org

ifeq ($(FLAVOUR),$(filter $(FLAVOUR),neutrino-ni))
GRAPHLCD_BASE_CUSTOM_PATCH += 0004-material-colors.patch
else
GRAPHLCD_BASE_CUSTOM_PATCH += 0003-material-colors.patch
endif

ifeq ($(BOXMODEL),$(filter $(BOXMODEL),vuduo4k vuduo4kse vusolo4k vuultimo4k vuuno4kse))
GRAPHLCD_BASE_CUSTOM_PATCH += 0005-add-vuplus-driver.patch
endif

define GRAPHLCD_BASE_CUSTOM_PATCHES
	$(APPLY_PATCHES) $(PKG_BUILD_DIR) $(PKG_PATCHES_DIR)/custom \$(GRAPHLCD_BASE_CUSTOM_PATCH)
endef
GRAPHLCD_BASE_POST_PATCH_HOOKS += GRAPHLCD_BASE_CUSTOM_PATCHES

GRAPHLCD_BASE_CONF_OPTS = \
	$(BUILD_ENV) \
	CXXFLAGS+="-fPIC" \
	TARGET=$(TARGET_CROSS) \
	PREFIX=/usr \
	DESTDIR=$(TARGET_DIR)

$(D)/graphlcd-base: bootstrap freetype libiconv libusb
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(MAKE) $($(PKG)_CONF_OPTS) -C glcdgraphics; \
		$(MAKE) $($(PKG)_CONF_OPTS) -C glcddrivers; \
		$(MAKE) $($(PKG)_CONF_OPTS) -C glcdgraphics install; \
		$(MAKE) $($(PKG)_CONF_OPTS) -C glcddrivers install; \
		$(INSTALL_DATA) -D graphlcd.conf $(TARGET_DIR)/etc/graphlcd.conf
	$(PKG_REMOVE)
	$(TOUCH)
