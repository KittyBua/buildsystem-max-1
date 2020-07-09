#
# slingshot
#
SLINGSHOT_VER    = 6
SLINGSHOT_DIR    = slingshot-$(SLINGSHOT_VER)
SLINGSHOT_SOURCE = slingshot-$(SLINGSHOT_VER).tar.gz
SLINGSHOT_SITE   = $(call github,gvvaughan,slingshot,v$(SLINGSHOT_VER))

$(D)/slingshot: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(TOUCH)
