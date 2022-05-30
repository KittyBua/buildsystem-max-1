################################################################################
#
# pngpp
#
################################################################################

PNGPP_VERSION = 0.2.9
PNGPP_DIR     = png++-$(PNGPP_VERSION)
PNGPP_SOURCE  = png++-$(PNGPP_VERSION).tar.gz
PNGPP_SITE    = https://download.savannah.gnu.org/releases/pngpp
PNGPP_DEPENDS = bootstrap libpng

$(D)/pngpp:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) install-headers PREFIX=$(TARGET_DIR)/usr
	$(call TARGET_FOLLOWUP)
