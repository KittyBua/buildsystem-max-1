#
# iozone
#
IOZONE_VER    = 3_490
IOZONE_DIR    = iozone$(IOZONE_VER)
IOZONE_SOURCE = iozone$(IOZONE_VER).tar
IOZONE_SITE   = http://www.iozone.org/src/current
IOZONEL_DEPS   = bootstrap

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
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		cd src/current; \
		$(TARGET_CONFIGURE_ENV); \
		$(MAKE) linux-arm
		$(INSTALL_EXEC) $(PKG_BUILD_DIR)/src/current/iozone $(TARGET_DIR)/usr/bin
	$(REMOVE)
	$(TOUCH)
