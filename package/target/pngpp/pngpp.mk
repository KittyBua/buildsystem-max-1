#
# pngpp
#
PNGPP_VER    = 0.2.9
PNGPP_DIR    = png++-$(PNGPP_VER)
PNGPP_SOURCE = png++-$(PNGPP_VER).tar.gz
PNGPP_SITE   = https://download.savannah.gnu.org/releases/pngpp
PNGPP_DEPS   = bootstrap libpng

$(D)/pngpp:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(MAKE) install-headers PREFIX=$(TARGET_DIR)/usr
	$(REMOVE)
	$(TOUCH)
