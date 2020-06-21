#
# fbshot
#
FBSHOT_VER    = 0.3
FBSHOT_DIR    = fbshot-$(FBSHOT_VER)
FBSHOT_SOURCE = fbshot-$(FBSHOT_VER).tar.gz
FBSHOT_SITE   = http://distro.ibiblio.org/amigolinux/download/Utils/fbshot

FBSHOT_PATCH  = \
	0001-fbshot.patch

$(D)/fbshot: bootstrap libpng
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		sed -i s~'gcc'~"$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS)"~ Makefile; \
		sed -i 's/strip fbshot/$(TARGET_STRIP) fbshot/' Makefile; \
		$(MAKE) all; \
		$(INSTALL_EXEC) -D fbshot $(TARGET_DIR)/bin/fbshot
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
