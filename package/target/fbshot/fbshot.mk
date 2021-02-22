#
# fbshot
#
FBSHOT_VER    = 0.3
FBSHOT_DIR    = fbshot-$(FBSHOT_VER)
FBSHOT_SOURCE = fbshot-$(FBSHOT_VER).tar.gz
FBSHOT_SITE   = http://distro.ibiblio.org/amigolinux/download/Utils/fbshot
FBSHOL_DEPS   = bootstrap libpng

define FBSHOT_POST_PATCH
	$(SED) s~'gcc'~"$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS)"~ $(PKG_BUILD_DIR)/Makefile
	$(SED) s~'strip fbshot'~"$(TARGET_STRIP) fbshot"~ $(PKG_BUILD_DIR)/Makefile
endef
FBSHOT_POST_PATCH_HOOKS = FBSHOT_POST_PATCH

$(D)/fbshot:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(MAKE); \
		$(INSTALL_EXEC) -D fbshot $(TARGET_DIR)/bin/fbshot
	$(REMOVE)
	$(TOUCH)
