#
# udpxy
#
UDPXY_VER    = git
UDPXY_DIR    = udpxy.git
UDPXY_SOURCE = udpxy.git
UDPXY_SITE   = https://github.com/pcherenkov
UDPXY_DEPS   = bootstrap

$(D)/udpxy:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(TARGET_CONFIGURE_ENV) \
		$(MAKE) -C chipmunk; \
		$(MAKE) -C chipmunk install INSTALLROOT=$(TARGET_DIR)/usr MANPAGE_DIR=$(TARGET_DIR)$(REMOVE_mandir)
	$(REMOVE)
	$(TOUCH)
