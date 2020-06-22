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
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(BUILD_ENV) \
		$(MAKE) CC=$(TARGET_CC); \
		$(MAKE) install TARGET_DIR=$(TARGET_DIR) install
	$(PKG_REMOVE)
	$(TOUCH)
