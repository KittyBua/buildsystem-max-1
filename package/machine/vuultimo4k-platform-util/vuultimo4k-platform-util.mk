################################################################################
#
# vuultimo4k-platform-util
#
################################################################################

VUULTIMO4K_PLATFORM_UTIL_DATE    = $(VUULTIMO4K_DRIVER_DATE)
VUULTIMO4K_PLATFORM_UTIL_REV     = r0
VUULTIMO4K_PLATFORM_UTIL_VERSION = 17.1-$(VUULTIMO4K_PLATFORM_UTIL_DATE).$(VUULTIMO4K_PLATFORM_UTIL_REV)
VUULTIMO4K_PLATFORM_UTIL_DIR     = platform-util-vuultimo4k
VUULTIMO4K_PLATFORM_UTIL_SOURCE  = platform-util-vuultimo4k-$(VUULTIMO4K_PLATFORM_UTIL_VERSION).tar.gz
VUULTIMO4K_PLATFORM_UTIL_SITE    = http://code.vuplus.com/download/release/platform-util
VUULTIMO4K_PLATFORM_UTIL_DEPENDS = bootstrap

define VUULTIMO4K_PLATFORM_UTIL_INSTALL_FILES
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-platform-util $(TARGET_DIR)/etc/init.d/vuplus-platform-util
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-shutdown $(TARGET_DIR)/etc/init.d/vuplus-shutdown
endef
VUULTIMO4K_PLATFORM_UTIL_PRE_INSTALL_TARGET_HOOKS += VUULTIMO4K_PLATFORM_UTIL_INSTALL_FILES

define VUULTIMO4K_PLATFORM_UTIL_INSTALL_INIT_SYSV
	$(UPDATE-RC.D) vuplus-platform-util start 65 S . stop 90 0 .
	$(UPDATE-RC.D) vuplus-shutdown start 89 0 .
endef

$(D)/vuultimo4k-platform-util:
	$(call PREPARE)
	$(INSTALL_EXEC) $(BUILD_DIR)/platform-util-vuultimo4k/* $(TARGET_BIN_DIR)
	$(call TARGET_FOLLOWUP)
