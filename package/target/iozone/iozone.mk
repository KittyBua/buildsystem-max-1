#
# iozone
#
IOZONE_VERSION = 3_490
IOZONE_DIR     = iozone$(IOZONE_VERSION)
IOZONE_SOURCE  = iozone$(IOZONE_VERSION).tar
IOZONE_SITE    = http://www.iozone.org/src/current
IOZONE_DEPENDS = bootstrap

define IOZONE_POST_PATCH
	$(SED) s~'gcc'~"$(TARGET_CC)"~ $(PKG_BUILD_DIR)/src/current/makefile
	$(SED) s~' cc'~"$(TARGET_CC)"~ $(PKG_BUILD_DIR)/src/current/makefile
endef
IOZONE_POST_PATCH_HOOKS = IOZONE_POST_PATCH

$(D)/iozone:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		cd src/current; \
		$(TARGET_CONFIGURE_OPTS); \
		$(MAKE) linux-arm
		$(INSTALL_EXEC) $(PKG_BUILD_DIR)/src/current/iozone $(TARGET_DIR)/usr/bin
	$(REMOVE)
	$(TOUCH)
