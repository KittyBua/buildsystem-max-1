#
# fbshot
#
FBSHOT_VER    = 0.3
FBSHOT_DIR    = fbshot-$(FBSHOT_VER)
FBSHOT_SOURCE = fbshot-$(FBSHOT_VER).tar.gz
FBSHOT_SITE   = http://distro.ibiblio.org/amigolinux/download/Utils/fbshot

define FBSHOT_POST_PATCH
	$(SED) s~'gcc'~"$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS)"~ $(PKG_BUILD_DIR)/Makefile
	$(SED) 's/strip fbshot/$(TARGET_STRIP) fbshot/' $(PKG_BUILD_DIR)/Makefile
endef
FBSHOT_POST_PATCH_HOOKS = FBSHOT_POST_PATCH

$(D)/fbshot: bootstrap libpng
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(MAKE); \
		$(INSTALL_EXEC) -D fbshot $(TARGET_DIR)/bin/fbshot
	$(PKG_REMOVE)
	$(TOUCH)
