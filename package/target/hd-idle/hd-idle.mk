#
# hd-idle
#
HD_IDLE_VERSION = 1.05
HD_IDLE_DIR     = hd-idle
HD_IDLE_SOURCE  = hd-idle-$(HD_IDLE_VERSION).tgz
HD_IDLE_SITE    = https://sourceforge.net/projects/hd-idle/files
HD_IDLE_DEPENDS = bootstrap

$(D)/hd-idle:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(TARGET_CONFIGURE_OPTS) \
		$(MAKE); \
		$(MAKE) install TARGET_DIR=$(TARGET_DIR) install
	$(REMOVE)
	$(TOUCH)
