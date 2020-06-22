#
# udpxy
#
UDPXY_VER    = git
UDPXY_DIR    = udpxy.git
UDPXY_SOURCE = udpxy.git
UDPXY_SITE   = https://github.com/pcherenkov

UDPXY_PATCH  = \
	0001-udpxy.patch \
	0002-fix-build-with-gcc8.patch

$(D)/udpxy: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_CPDIR)
	$(PKG_CHDIR)/chipmunk; \
		$(call apply_patches, $(PKG_PATCH)); \
		$(BUILD_ENV) \
		$(MAKE) CC=$(TARGET_CC); \
		$(MAKE) install INSTALLROOT=$(TARGET_DIR)/usr MANPAGE_DIR=$(TARGET_DIR)/.remove
	$(PKG_REMOVE)
	$(TOUCH)
