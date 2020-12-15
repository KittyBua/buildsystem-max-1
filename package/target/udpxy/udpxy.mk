#
# udpxy
#
UDPXY_VER    = git
UDPXY_DIR    = udpxy.git
UDPXY_SOURCE = udpxy.git
UDPXY_SITE   = https://github.com/pcherenkov

UDPXY_PATCH = \
	0001-udpxy.patch \
	0002-fix-build-with-gcc8.patch

$(D)/udpxy: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(BUILD_ENV) \
		$(MAKE) -C chipmunk; \
		$(MAKE) -C chipmunk install INSTALLROOT=$(TARGET_DIR)/usr MANPAGE_DIR=$(TARGET_DIR)$(REMOVE_mandir)
	$(PKG_REMOVE)
	$(TOUCH)
