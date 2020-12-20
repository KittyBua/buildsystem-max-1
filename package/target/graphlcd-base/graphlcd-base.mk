#
# graphlcd-base
#
GRAPHLCD_BASE_VER    = git
GRAPHLCD_BASE_DIR    = graphlcd-base.git
GRAPHLCD_BASE_SOURCE = graphlcd-base.git
GRAPHLCD_BASE_SITE   = git://projects.vdr-developer.org

GRAPHLCD_BASE_PATCH = \
	0001-graphlcd.patch \
	0002-strip-graphlcd-conf.patch

ifeq ($(FLAVOUR), $(filter $(FLAVOUR),neutrino-ni))
GRAPHLCD_BASE_PATCH += \
	0004-material-colors.patch
else 
GRAPHLCD_BASE_PATCH += \
	0003-material-colors.patch
endif

ifeq ($(BOXMODEL), $(filter $(BOXMODEL),vuduo4k vuduo4kse vusolo4k vuultimo4k vuuno4kse))
GRAPHLCD_BASE_PATCH += \
	0005-add-vuplus-driver.patch
endif

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
	$(PKG_CHDIR); \
		$(call apply_patches,$(PKG_PATCH)); \
		$(MAKE) $(PKG_CONF_OPTS) -C glcdgraphics all; \
		$(MAKE) $(PKG_CONF_OPTS) -C glcddrivers all; \
		$(MAKE) $(PKG_CONF_OPTS) -C glcdgraphics install; \
		$(MAKE) $(PKG_CONF_OPTS) -C glcddrivers install; \
		$(INSTALL_DATA) -D graphlcd.conf $(TARGET_DIR)/etc/graphlcd.conf
	$(PKG_REMOVE)
	$(TOUCH)
