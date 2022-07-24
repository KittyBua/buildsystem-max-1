################################################################################
#
# vuduo4kse-driver
#
################################################################################

VUDUO4KSE_DRIVER_DATE = 20200903
VUDUO4KSE_DRIVER_REV = r0
VUDUO4KSE_DRIVER_VERSION = 4.1.45-$(VUDUO4KSE_DRIVER_DATE).$(VUDUO4KSE_DRIVER_REV)
VUDUO4KSE_DRIVER_SOURCE = vuplus-dvb-proxy-vuduo4kse-$(VUDUO4KSE_DRIVER_VERSION).tar.gz
VUDUO4KSE_DRIVER_SITE = http://code.vuplus.com/download/release/vuplus-dvb-proxy

$(D)/vuduo4kse-driver: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	$(call TARGET_FOLLOWUP)

################################################################################
#
# vuduo4kse-libgles
#
################################################################################

VUDUO4KSE_LIBGLES_DATE = $(VUDUO4KSE_DRIVER_DATE)
VUDUO4KSE_LIBGLES_REV = r0
VUDUO4KSE_LIBGLES_VERSION = 17.1-$(VUDUO4KSE_LIBGLES_DATE).$(VUDUO4KSE_LIBGLES_REV)
VUDUO4KSE_LIBGLES_DIR = libgles-vuduo4kse
VUDUO4KSE_LIBGLES_SOURCE = libgles-vuduo4kse-$(VUDUO4KSE_LIBGLES_VERSION).tar.gz
VUDUO4KSE_LIBGLES_SITE = http://code.vuplus.com/download/release/libgles

$(D)/vuduo4kse-libgles: | bootstrap
	$(call PREPARE)
	$(INSTALL_EXEC) $(BUILD_DIR)/libgles-vuduo4kse/lib/* $(TARGET_LIB_DIR)
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	cp -a $(BUILD_DIR)/libgles-vuduo4kse/include/* $(TARGET_INCLUDE_DIR)
	$(call TARGET_FOLLOWUP)

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

################################################################################
#
# vuduo4kse-vmlinuz-initrd 7278b1
#
################################################################################

ifeq ($(VU_MULTIBOOT),multi)
VUDUO4KSE_VMLINUZ_INITRD_DATE = 20201010
VUDUO4KSE_VMLINUZ_INITRD_SITE = https://bitbucket.org/max_10/vmlinuz-initrd-vuduo4kse/downloads
else
VUDUO4KSE_VMLINUZ_INITRD_DATE = 20200326
VUDUO4KSE_VMLINUZ_INITRD_SITE = http://code.vuplus.com/download/release/kernel
endif
VUDUO4KSE_VMLINUZ_INITRD_VERSION = $(VUDUO4KSE_VMLINUZ_INITRD_DATE)
VUDUO4KSE_VMLINUZ_INITRD_SOURCE  = vmlinuz-initrd_vuduo4kse_$(VUDUO4KSE_VMLINUZ_INITRD_VERSION).tar.gz

$(D)/vuduo4kse-vmlinuz-initrd: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(call TARGET_FOLLOWUP)
