#
# hd-idle
#
HD_IDLE_VER    = 1.05
HD_IDLE_DIR    = hd-idle
HD_IDLE_SOURCE = hd-idle-$(HD_IDLE_VER).tgz
HD_IDLE_SITE   = https://sourceforge.net/projects/hd-idle/files

HD_IDLE_PATCH  = \
	0001-hd-idle.patch

$(D)/hd-idle: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(BUILD_ENV) \
		$(MAKE) CC=$(TARGET_CC); \
		$(MAKE) install TARGET_DIR=$(TARGET_DIR) install
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
