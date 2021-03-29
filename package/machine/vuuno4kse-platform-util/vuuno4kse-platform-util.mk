#
# vuuno4kse-platform-util
#
VUUNO4KSE_PLATFORM_UTIL_DATE    = $(VUUNO4KSE_DRIVER_DATE)
VUUNO4KSE_PLATFORM_UTIL_REV     = r0
VUUNO4KSE_PLATFORM_UTIL_VERSION = 17.1-$(VUUNO4KSE_PLATFORM_UTIL_DATE).$(VUUNO4KSE_PLATFORM_UTIL_REV)
VUUNO4KSE_PLATFORM_UTIL_DIR     = platform-util-vuuno4kse
VUUNO4KSE_PLATFORM_UTIL_SOURCE  = platform-util-vuuno4kse-$(VUUNO4KSE_PLATFORM_UTIL_VERSION).tar.gz
VUUNO4KSE_PLATFORM_UTIL_SITE    = http://code.vuplus.com/download/release/platform-util
VUUNO4KSE_PLATFORM_UTIL_DEPENDS = bootstrap

vuuno4kse-platform-util:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(INSTALL_EXEC) $(BUILD_DIR)/platform-util-vuuno4kse/* $(TARGET_DIR)/usr/bin
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-platform-util $(TARGET_DIR)/etc/init.d/vuplus-platform-util
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-shutdown $(TARGET_DIR)/etc/init.d/vuplus-shutdown
	$(UPDATE-RC.D) vuplus-platform-util start 65 S . stop 90 0 .
	$(UPDATE-RC.D) vuplus-shutdown start 89 0 .
	$(REMOVE)
	$(TOUCH)
