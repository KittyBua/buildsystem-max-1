################################################################################
#
# graphlcd-base
#
################################################################################

GRAPHLCD_BASE_VERSION = 2.0.3
GRAPHLCD_BASE_DIR = graphlcd-base-$(GRAPHLCD_BASE_VERSION)
GRAPHLCD_BASE_SOURCE = graphlcd-base-$(GRAPHLCD_BASE_VERSION).tar.bz2
GRAPHLCD_BASE_SITE = https://vdr-projects.e-tobi.net/git/graphlcd-base/snapshot/

GRAPHLCD_BASE_DEPENDS = bootstrap freetype libiconv libusb

ifeq ($(FLAVOUR),$(filter $(FLAVOUR),neutrino-ni))
GRAPHLCD_BASE_PATCH += 0004-material-colors.patch-custom
else
GRAPHLCD_BASE_PATCH += 0003-material-colors.patch-custom
endif

ifeq ($(BOXMODEL),$(filter $(BOXMODEL),vuduo4k vuduo4kse vusolo4k vuultimo4k vuuno4kse))
GRAPHLCD_BASE_PATCH += 0005-add-vuplus-driver.patch-custom
endif

GRAPHLCD_BASE_CONF_OPTS = \
	$(TARGET_CONFIGURE_ENV) \
	CXXFLAGS+="-fPIC" \
	TARGET=$(TARGET_CROSS) \
	PREFIX=/usr \
	DESTDIR=$(TARGET_DIR)

$(D)/graphlcd-base:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) $($(PKG)_CONF_OPTS) -C glcdgraphics; \
		$(MAKE) $($(PKG)_CONF_OPTS) -C glcddrivers; \
		$(MAKE) $($(PKG)_CONF_OPTS) -C glcdgraphics install; \
		$(MAKE) $($(PKG)_CONF_OPTS) -C glcddrivers install; \
		$(INSTALL_DATA) -D graphlcd.conf $(TARGET_DIR)/etc/graphlcd.conf
	$(call TARGET_FOLLOWUP)
