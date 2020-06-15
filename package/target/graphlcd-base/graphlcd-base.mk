#
# graphlcd-base
#
GRAPHLCD_BASE_VER    = git
GRAPHLCD_BASE_DIR    = graphlcd-base.git
GRAPHLCD_BASE_SOURCE = graphlcd-base.git
GRAPHLCD_BASE_URL    = git://projects.vdr-developer.org

GRAPHLCD_BASE_PATCH  = \
	0001-graphlcd.patch \
	0002-strip-graphlcd-conf.patch

ifeq ($(FLAVOUR), $(filter $(FLAVOUR), neutrino-ni))
GRAPHLCD_BASE_PATCH += \
	0004-material-colors.patch
else 
GRAPHLCD_BASE_PATCH += \
	0003-material-colors.patch
endif

ifeq ($(BOXMODEL), $(filter $(BOXMODEL), vuduo4k vusolo4k vuultimo4k vuuno4kse))
GRAPHLCD_BASE_PATCH += \
	0005-add-vuplus-driver.patch
endif

GRAPHLCD_BASE_MAKE_OPTS = \
	$(BUILD_ENV) \
	CXXFLAGS+="-fPIC" \
	TARGET=$(TARGET_CROSS) \
	PREFIX=/usr \
	DESTDIR=$(TARGET_DIR)

$(D)/graphlcd-base: bootstrap freetype libiconv libusb
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(CPDIR)/$(PKG_DIR)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(MAKE) $(GRAPHLCD_BASE_MAKE_OPTS) -C glcdgraphics all; \
		$(MAKE) $(GRAPHLCD_BASE_MAKE_OPTS) -C glcddrivers all; \
		$(MAKE) $(GRAPHLCD_BASE_MAKE_OPTS) -C glcdgraphics install; \
		$(MAKE) $(GRAPHLCD_BASE_MAKE_OPTS) -C glcddrivers install; \
		$(INSTALL_DATA) -D graphlcd.conf $(TARGET_DIR)/etc/graphlcd.conf
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
