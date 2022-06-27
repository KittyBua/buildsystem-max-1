################################################################################
#
# vusolo4k-platform-util
#
################################################################################

VUSOLO4K_PLATFORM_UTIL_DATE    = $(VUSOLO4K_DRIVER_DATE)
VUSOLO4K_PLATFORM_UTIL_REV     = r0
VUSOLO4K_PLATFORM_UTIL_VERSION = 17.1-$(VUSOLO4K_PLATFORM_UTIL_DATE).$(VUSOLO4K_PLATFORM_UTIL_REV)
VUSOLO4K_PLATFORM_UTIL_DIR     = platform-util-vusolo4k
VUSOLO4K_PLATFORM_UTIL_SOURCE  = platform-util-vusolo4k-$(VUSOLO4K_PLATFORM_UTIL_VERSION).tar.gz
VUSOLO4K_PLATFORM_UTIL_SITE    = http://code.vuplus.com/download/release/platform-util
VUSOLO4K_PLATFORM_UTIL_DEPENDS = bootstrap

define VUSOLO4K_PLATFORM_UTIL_INSTALL_FILES
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-platform-util $(TARGET_DIR)/etc/init.d/vuplus-platform-util
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-shutdown $(TARGET_DIR)/etc/init.d/vuplus-shutdown
endef
VUSOLO4K_PLATFORM_UTIL_POST_FOLLOWUP_HOOKS += VUSOLO4K_PLATFORM_UTIL_INSTALL_FILES

define VUSOLO4K_PLATFORM_UTIL_INSTALL_INIT_SYSV
	$(UPDATE-RC.D) vuplus-platform-util start 65 S . stop 90 0 .
	$(UPDATE-RC.D) vuplus-shutdown start 89 0 .
endef

$(D)/vusolo4k-platform-util:
	$(call PREPARE)
	$(INSTALL_EXEC) $(BUILD_DIR)/platform-util-vusolo4k/* $(TARGET_BIN_DIR)
	$(call TARGET_FOLLOWUP)
