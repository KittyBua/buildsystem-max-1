################################################################################
#
# fbshot
#
################################################################################

FBSHOT_VERSION = 0.3
FBSHOT_DIR     = fbshot-$(FBSHOT_VERSION)
FBSHOT_SOURCE  = fbshot-$(FBSHOT_VERSION).tar.gz
FBSHOT_SITE    = http://distro.ibiblio.org/amigolinux/download/Utils/fbshot
FBSHOT_DEPENDS = bootstrap libpng

define FBSHOT_POST_PATCH
	$(SED) s~'gcc'~"$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS)"~ $(PKG_BUILD_DIR)/Makefile
	$(SED) s~'strip fbshot'~"$(TARGET_STRIP) fbshot"~ $(PKG_BUILD_DIR)/Makefile
endef
FBSHOT_POST_PATCH_HOOKS = FBSHOT_POST_PATCH

$(D)/fbshot:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE); \
		$(INSTALL_EXEC) -D fbshot $(TARGET_DIR)/bin/fbshot
	$(call TARGET_FOLLOWUP)
