#
# vuzero4k-platform-util
#
VUZERO4K_PLATFORM_UTIL_DATE   = $(VUZERO4K_DRIVER_DATE)
VUZERO4K_PLATFORM_UTIL_REV    = r0
VUZERO4K_PLATFORM_UTIL_VER    = 17.1-$(VUZERO4K_PLATFORM_UTIL_DATE).$(VUZERO4K_PLATFORM_UTIL_REV)
VUZERO4K_PLATFORM_UTIL_SOURCE = platform-util-vuzero4k-$(VUZERO4K_PLATFORM_UTIL_VER).tar.gz
VUZERO4K_PLATFORM_UTIL_SITE   = http://archive.vuplus.com/download/build_support/vuplus

$(D)/vuzero4k-platform-util: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/platform-util-vuzero4k
	$(PKG_UNPACK)
	$(INSTALL_EXEC) $(BUILD_DIR)/platform-util-vuzero4k/* $(TARGET_DIR)/usr/bin
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-platform-util $(TARGET_DIR)/etc/init.d/vuplus-platform-util
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-shutdown $(TARGET_DIR)/etc/init.d/vuplus-shutdown
	$(UPDATE-RC.D) vuplus-platform-util start 65 S . stop 90 0 .
	$(UPDATE-RC.D) vuplus-shutdown start 89 0 .
	$(REMOVE)/platform-util-vuzero4k
	$(TOUCH)
