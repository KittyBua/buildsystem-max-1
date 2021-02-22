#
# hd-idle
#
HD_IDLE_VER    = 1.05
HD_IDLE_DIR    = hd-idle
HD_IDLE_SOURCE = hd-idle-$(HD_IDLE_VER).tgz
HD_IDLE_SITE   = https://sourceforge.net/projects/hd-idle/files
HD_IDLE_DEPS   = bootstrap

$(D)/hd-idle:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(TARGET_CONFIGURE_ENV) \
		$(MAKE); \
		$(MAKE) install TARGET_DIR=$(TARGET_DIR) install
	$(REMOVE)
	$(TOUCH)
