################################################################################
#
# vuduo4k-platform-util
#
################################################################################

VUDUO4K_PLATFORM_UTIL_DATE    = $(VUDUO4K_DRIVER_DATE)
VUDUO4K_PLATFORM_UTIL_REV     = r0
VUDUO4K_PLATFORM_UTIL_VERSION = 18.1-$(VUDUO4K_PLATFORM_UTIL_DATE).$(VUDUO4K_PLATFORM_UTIL_REV)
VUDUO4K_PLATFORM_UTIL_DIR     = platform-util-vuduo4k
VUDUO4K_PLATFORM_UTIL_SOURCE  = platform-util-vuduo4k-$(VUDUO4K_PLATFORM_UTIL_VERSION).tar.gz
VUDUO4K_PLATFORM_UTIL_SITE    = http://code.vuplus.com/download/release/platform-util
VUDUO4K_PLATFORM_UTIL_DEPENDS = bootstrap

define VUDUO4K_PLATFORM_UTIL_INSTALL_FILES
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-platform-util $(TARGET_DIR)/etc/init.d/vuplus-platform-util
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-shutdown $(TARGET_DIR)/etc/init.d/vuplus-shutdown
endef
VUDUO4K_PLATFORM_UTIL_PRE_INSTALL_TARGET_HOOKS += VUDUO4K_PLATFORM_UTIL_INSTALL_FILES

define VUDUO4K_PLATFORM_UTIL_INSTALL_INIT_SYSV
	$(UPDATE-RC.D) vuplus-platform-util start 65 S . stop 90 0 .
	$(UPDATE-RC.D) vuplus-shutdown start 89 0 
endef

$(D)/vuduo4k-platform-util:
	$(call PREPARE)
	$(INSTALL_EXEC) $(BUILD_DIR)/platform-util-vuduo4k/* $(TARGET_BIN_DIR)
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/bp3flash.sh $(TARGET_BIN_DIR)/bp3flash.sh
	$(call TARGET_FOLLOWUP)
