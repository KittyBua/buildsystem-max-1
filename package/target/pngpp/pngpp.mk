#
# pngpp
#
PNGPP_VER    = 0.2.9
PNGPP_DIR    = png++-$(PNGPP_VER)
PNGPP_SOURCE = png++-$(PNGPP_VER).tar.gz
PNGPP_SITE   = https://download.savannah.gnu.org/releases/pngpp

$(D)/pngpp: bootstrap libpng
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(MAKE) install-headers PREFIX=$(TARGET_DIR)/usr
	$(PKG_REMOVE)
	$(TOUCH)
