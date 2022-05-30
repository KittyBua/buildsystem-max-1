################################################################################
#
# vuzero4k-platform-util
#
################################################################################

VUZERO4K_PLATFORM_UTIL_DATE    = $(VUZERO4K_DRIVER_DATE)
VUZERO4K_PLATFORM_UTIL_REV     = r0
VUZERO4K_PLATFORM_UTIL_VERSION = 17.1-$(VUZERO4K_PLATFORM_UTIL_DATE).$(VUZERO4K_PLATFORM_UTIL_REV)
VUZERO4K_PLATFORM_UTIL_DIR     = platform-util-vuzero4k
VUZERO4K_PLATFORM_UTIL_SOURCE  = platform-util-vuzero4k-$(VUZERO4K_PLATFORM_UTIL_VERSION).tar.gz
VUZERO4K_PLATFORM_UTIL_SITE    = http://code.vuplus.com/download/release/platform-util
VUZERO4K_PLATFORM_UTIL_DEPENDS = bootstrap

define VUZERO4K_PLATFORM_UTIL_INSTALL_FILES
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-platform-util $(TARGET_DIR)/etc/init.d/vuplus-platform-util
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-shutdown $(TARGET_DIR)/etc/init.d/vuplus-shutdown
endef
VUZERO4K_PLATFORM_UTIL_PRE_INSTALL_TARGET_HOOKS += VUZERO4K_PLATFORM_UTIL_INSTALL_FILES

define VUZERO4K_PLATFORM_UTIL_INSTALL_INIT_SYSV
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-platform-util $(TARGET_DIR)/etc/init.d/vuplus-platform-util
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-shutdown $(TARGET_DIR)/etc/init.d/vuplus-shutdown
	$(UPDATE-RC.D) vuplus-platform-util start 65 S . stop 90 0 .
	$(UPDATE-RC.D) vuplus-shutdown start 89 0 .
endef

$(D)/vuzero4k-platform-util:
	$(call PREPARE)
	$(INSTALL_EXEC) $(BUILD_DIR)/platform-util-vuzero4k/* $(TARGET_BIN_DIR)
	$(call TARGET_FOLLOWUP)
