#
# graphlcd-base
#
GRAPHLCD_BASE_VER    = git
GRAPHLCD_BASE_DIR    = graphlcd-base.git
GRAPHLCD_BASE_SOURCE = graphlcd-base.git
GRAPHLCD_BASE_URL    = git://projects.vdr-developer.org

GRAPHLCD_BASE_PATCH  = \
	0001-graphlcd.patch

ifeq ($(FLAVOUR), $(filter $(FLAVOUR), neutrino-ni))
GRAPHLCD_BASE_PATCH += \
	0004-material-colors.patch
else 
GRAPHLCD_BASE_PATCH += \
	0003-material-colors.patch
endif

ifeq ($(BOXMODEL), $(filter $(BOXMODEL), vuduo4k vusolo4k vuultimo4k vuuno4kse))
GRAPHLCD_BASE_PATCH += \
	0002-graphlcd-vuplus.patch
endif

$(D)/graphlcd-base: bootstrap freetype libiconv libusb
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(CPDIR)/$(PKG_DIR)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(MAKE) -C glcdgraphics all TARGET=$(TARGET_CROSS) DESTDIR=$(TARGET_DIR); \
		$(MAKE) -C glcddrivers all TARGET=$(TARGET_CROSS) DESTDIR=$(TARGET_DIR); \
		$(MAKE) -C glcdgraphics install DESTDIR=$(TARGET_DIR); \
		$(MAKE) -C glcddrivers install DESTDIR=$(TARGET_DIR); \
		cp -a graphlcd.conf $(TARGET_DIR)/etc
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
