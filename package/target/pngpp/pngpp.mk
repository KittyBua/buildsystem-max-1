#
# pngpp
#
PNGPP_VER    = 0.2.9
PNGPP_DIR    = png++-$(PNGPP_VER)
PNGPP_SOURCE = png++-$(PNGPP_VER).tar.gz
PNGPP_SITE   = https://download.savannah.gnu.org/releases/pngpp

$(D)/pngpp: bootstrap libpng
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(MAKE) install-headers PREFIX=$(TARGET_DIR)/usr
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
