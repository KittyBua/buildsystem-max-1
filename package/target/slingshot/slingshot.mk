#
# slingshot
#
SLINGSHOT_VER    = 6
SLINGSHOT_DIR    = slingshot-$(SLINGSHOT_VER)
SLINGSHOT_SOURCE = slingshot-$(SLINGSHOT_VER).tar.gz
SLINGSHOT_GIT    = v$(SLINGSHOT_VER).tar.gz -O $(DL_DIR)/$(SLINGSHOT_SOURCE)
SLINGSHOT_URL    = https://github.com/gvvaughan/slingshot/archive

$(D)/slingshot: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(SLINGSHOT_GIT))
	$(TOUCH)
