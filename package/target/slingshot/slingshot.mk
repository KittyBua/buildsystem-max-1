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
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(TOUCH)
