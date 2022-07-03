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

define FBSHOT_PATCH_MAKEFILE
	$(SED) 's|	gcc |	$(TARGET_CC) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) |' $(PKG_BUILD_DIR)/Makefile
	$(SED) '/strip fbshot/d' $(PKG_BUILD_DIR)/Makefile
	$(SED) 's|/usr/bin/fbshot|$$(DESTDIR)/usr/bin/fbshot|' $(PKG_BUILD_DIR)/Makefile
	$(SED) '/install fbshot.1.man/d' $(PKG_BUILD_DIR)/Makefile
endef
FBSHOT_POST_PATCH_HOOKS += FBSHOT_PATCH_MAKEFILE

$(D)/fbshot:
	$(call make-package)
