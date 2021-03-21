#
# pngpp
#
PNGPP_VERSION = 0.2.9
PNGPP_DIR     = png++-$(PNGPP_VERSION)
PNGPP_SOURCE  = png++-$(PNGPP_VERSION).tar.gz
PNGPP_SITE    = https://download.savannah.gnu.org/releases/pngpp
PNGPP_DEPENDS = bootstrap libpng

$(D)/pngpp:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(MAKE) install-headers PREFIX=$(TARGET_DIR)/usr
	$(REMOVE)
	$(TOUCH)
