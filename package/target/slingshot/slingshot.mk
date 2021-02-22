#
# slingshot
#
SLINGSHOT_VER    = 6
SLINGSHOT_DIR    = slingshot-$(SLINGSHOT_VER)
SLINGSHOT_SOURCE = slingshot-$(SLINGSHOT_VER).tar.gz
SLINGSHOT_SITE   = $(call github,gvvaughan,slingshot,v$(SLINGSHOT_VER))
SLINGSHOT_DEPS   = bootstrap

$(D)/slingshot:
	$(START_BUILD)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(TOUCH)
