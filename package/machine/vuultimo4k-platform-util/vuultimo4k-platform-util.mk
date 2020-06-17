#
# vuultimo4k-platform-util
#
VUULTIMO4K_PLATFORM_UTIL_DATE   = $(VUULTIMO4K_DRIVER_DATE)
VUULTIMO4K_PLATFORM_UTIL_REV    = r0
VUULTIMO4K_PLATFORM_UTIL_VER    = 17.1-$(VUULTIMO4K_PLATFORM_UTIL_DATE).$(VUULTIMO4K_PLATFORM_UTIL_REV)
VUULTIMO4K_PLATFORM_UTIL_SOURCE = platform-util-vuultimo4k-$(VUULTIMO4K_PLATFORM_UTIL_VER).tar.gz
VUULTIMO4K_PLATFORM_UTIL_SITE   = http://archive.vuplus.com/download/build_support/vuplus

$(D)/vuultimo4k-platform-util: bootstrap
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/platform-util-vuultimo4k
	$(UNTAR)/$(PKG_SOURCE)
	$(INSTALL_EXEC) $(BUILD_DIR)/platform-util-vuultimo4k/* $(TARGET_DIR)/usr/bin
	$(REMOVE)/platform-util-vuultimo4k
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-platform-util $(TARGET_DIR)/etc/init.d/vuplus-platform-util
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-shutdown $(TARGET_DIR)/etc/init.d/vuplus-shutdown
	$(UPDATE-RC.D) vuplus-platform-util start 65 S . stop 90 0 .
	$(UPDATE-RC.D) vuplus-shutdown start 89 0 .
	$(TOUCH)
