################################################################################
#
# vuduo4kSE-platform-util
#
################################################################################

VUDUO4KSE_PLATFORM_UTIL_DATE = $(VUDUO4KSE_DRIVER_DATE)
VUDUO4KSE_PLATFORM_UTIL_REV = r0
VUDUO4KSE_PLATFORM_UTIL_VERSION = 17.1-$(VUDUO4KSE_PLATFORM_UTIL_DATE).$(VUDUO4KSE_PLATFORM_UTIL_REV)
VUDUO4KSE_PLATFORM_UTIL_DIR = platform-util-vuduo4kse
VUDUO4KSE_PLATFORM_UTIL_SOURCE = platform-util-vuduo4kse-$(VUDUO4KSE_PLATFORM_UTIL_VERSION).tar.gz
VUDUO4KSE_PLATFORM_UTIL_SITE = http://code.vuplus.com/download/release/platform-util

define VUDUO4KSE_PLATFORM_UTIL_INSTALL_FILES
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-platform-util $(TARGET_DIR)/etc/init.d/vuplus-platform-util
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-shutdown $(TARGET_DIR)/etc/init.d/vuplus-shutdown
endef
VUDUO4KSE_PLATFORM_UTIL_POST_FOLLOWUP_HOOKS += VUDUO4KSE_PLATFORM_UTIL_INSTALL_FILES

define VUDUO4KSE_PLATFORM_UTIL_INSTALL_INIT_SYSV
	$(UPDATE-RC.D) vuplus-platform-util start 65 S . stop 90 0 .
	$(UPDATE-RC.D) vuplus-shutdown start 89 0 .
endef

$(D)/vuduo4kse-platform-util: | bootstrap
	$(call PREPARE)
	$(INSTALL_EXEC) $(BUILD_DIR)/platform-util-vuduo4kse/* $(TARGET_BIN_DIR)
	$(call TARGET_FOLLOWUP)
