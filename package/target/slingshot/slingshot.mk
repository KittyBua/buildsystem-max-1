################################################################################
#
# slingshot
#
################################################################################

SLINGSHOT_VERSION = 6
SLINGSHOT_DIR = slingshot-$(SLINGSHOT_VERSION)
SLINGSHOT_SOURCE = slingshot-$(SLINGSHOT_VERSION).tar.gz
SLINGSHOT_SITE = $(call github,gvvaughan,slingshot,v$(SLINGSHOT_VERSION))

SLINGSHOT_DEPENDS = bootstrap

$(D)/slingshot:
	$(call individual-package,$(PKG_NO_EXTRACT) $(PKG_NO_PATCHES) $(PKG_NO_BUILD) $(PKG_NO_INSTALL))
