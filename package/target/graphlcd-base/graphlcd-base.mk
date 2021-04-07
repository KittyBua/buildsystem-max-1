#
# graphlcd-base
#
GRAPHLCD_BASE_VERSION = git
GRAPHLCD_BASE_DIR     = graphlcd-base.git
GRAPHLCD_BASE_SOURCE  = graphlcd-base.git
GRAPHLCD_BASE_SITE    = git://projects.vdr-developer.org
GRAPHLCD_BASE_DEPENDS = bootstrap freetype libiconv libusb

ifeq ($(FLAVOUR),$(filter $(FLAVOUR),neutrino-ni))
GRAPHLCD_BASE_CUSTOM_PATCH += 0004-material-colors.patch.custom
else
GRAPHLCD_BASE_CUSTOM_PATCH += 0003-material-colors.patch.custom
endif

ifeq ($(BOXMODEL),$(filter $(BOXMODEL),vuduo4k vuduo4kse vusolo4k vuultimo4k vuuno4kse))
GRAPHLCD_BASE_CUSTOM_PATCH += 0005-add-vuplus-driver.patch.custom
endif

define GRAPHLCD_BASE_CUSTOM_PATCHES
	$(APPLY_PATCH) $(PKG_BUILD_DIR) $(PKG_PATCHES_DIR) $(GRAPHLCD_BASE_CUSTOM_PATCH)
endef
GRAPHLCD_BASE_POST_PATCH_HOOKS += GRAPHLCD_BASE_CUSTOM_PATCHES

GRAPHLCD_BASE_CONF_OPTS = \
	$(TARGET_CONFIGURE_OPTS) \
	CXXFLAGS+="-fPIC" \
	TARGET=$(TARGET_CROSS) \
	PREFIX=/usr \
	DESTDIR=$(TARGET_DIR)

$(D)/graphlcd-base:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(MAKE) $($(PKG)_CONF_OPTS) -C glcdgraphics; \
		$(MAKE) $($(PKG)_CONF_OPTS) -C glcddrivers; \
		$(MAKE) $($(PKG)_CONF_OPTS) -C glcdgraphics install; \
		$(MAKE) $($(PKG)_CONF_OPTS) -C glcddrivers install; \
		$(INSTALL_DATA) -D graphlcd.conf $(TARGET_DIR)/etc/graphlcd.conf
	$(REMOVE)
	$(TOUCH)
