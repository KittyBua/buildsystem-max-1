#
# vuultimo4k-platform-util
#
VUULTIMO4K_PLATFORM_UTIL_DATE   = $(VUULTIMO4K_DRIVER_DATE)
VUULTIMO4K_PLATFORM_UTIL_REV    = r0
VUULTIMO4K_PLATFORM_UTIL_VER    = 17.1-$(VUULTIMO4K_PLATFORM_UTIL_DATE).$(VUULTIMO4K_PLATFORM_UTIL_REV)
VUULTIMO4K_PLATFORM_UTIL_DIR    = platform-util-vuultimo4k
VUULTIMO4K_PLATFORM_UTIL_SOURCE = platform-util-vuultimo4k-$(VUULTIMO4K_PLATFORM_UTIL_VER).tar.gz
VUULTIMO4K_PLATFORM_UTIL_SITE   = http://archive.vuplus.com/download/build_support/vuplus

$(D)/vuultimo4k-platform-util: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(INSTALL_EXEC) $(BUILD_DIR)/platform-util-vuultimo4k/* $(TARGET_DIR)/usr/bin
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-platform-util $(TARGET_DIR)/etc/init.d/vuplus-platform-util
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-shutdown $(TARGET_DIR)/etc/init.d/vuplus-shutdown
	$(UPDATE-RC.D) vuplus-platform-util start 65 S . stop 90 0 .
	$(UPDATE-RC.D) vuplus-shutdown start 89 0 .
	$(PKG_REMOVE)
	$(TOUCH)
