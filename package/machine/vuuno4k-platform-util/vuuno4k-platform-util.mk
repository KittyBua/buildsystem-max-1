#
# vuuno4k-platform-util
#
VUUNO4K_PLATFORM_UTIL_DATE   = $(VUUNO4K_DRIVER_DATE)
VUUNO4K_PLATFORM_UTIL_REV    = r0
VUUNO4K_PLATFORM_UTIL_VER    = 17.1-$(VUUNO4K_PLATFORM_UTIL_DATE).$(VUUNO4K_PLATFORM_UTIL_REV)
VUUNO4K_PLATFORM_UTIL_SOURCE = platform-util-vuuno4k-$(VUUNO4K_PLATFORM_UTIL_VER).tar.gz
VUUNO4K_PLATFORM_UTIL_SITE   = http://archive.vuplus.com/download/build_support/vuplus

$(D)/vuuno4k-platform-util: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/platform-util-vuuno4k
	$(PKG_UNPACK)
	$(INSTALL_EXEC) $(BUILD_DIR)/platform-util-vuuno4k/* $(TARGET_DIR)/usr/bin
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-platform-util $(TARGET_DIR)/etc/init.d/vuplus-platform-util
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-shutdown $(TARGET_DIR)/etc/init.d/vuplus-shutdown
	$(UPDATE-RC.D) vuplus-platform-util start 65 S . stop 90 0 .
	$(UPDATE-RC.D) vuplus-shutdown start 89 0 .
	$(REMOVE)/platform-util-vuuno4k
	$(TOUCH)
