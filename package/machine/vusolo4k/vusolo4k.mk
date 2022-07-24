################################################################################
#
# vusolo4k-driver
#
################################################################################

VUSOLO4K_DRIVER_DATE = 20190424
VUSOLO4K_DRIVER_REV = r0
VUSOLO4K_DRIVER_VERSION = 3.14.28-$(VUSOLO4K_DRIVER_DATE).$(VUSOLO4K_DRIVER_REV)
VUSOLO4K_DRIVER_SOURCE = vuplus-dvb-proxy-vusolo4k-$(VUSOLO4K_DRIVER_VERSION).tar.gz
VUSOLO4K_DRIVER_SITE = http://code.vuplus.com/download/release/vuplus-dvb-proxy

$(D)/vusolo4k-driver: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	$(call TARGET_FOLLOWUP)

################################################################################
#
# vusolo4k-libgles
#
################################################################################

VUSOLO4K_LIBGLES_DATE = $(VUSOLO4K_DRIVER_DATE)
VUSOLO4K_LIBGLES_REV = r0
VUSOLO4K_LIBGLES_VERSION = 17.1-$(VUSOLO4K_LIBGLES_DATE).$(VUSOLO4K_LIBGLES_REV)
VUSOLO4K_LIBGLES_DIR = libgles-vusolo4k
VUSOLO4K_LIBGLES_SOURCE = libgles-vusolo4k-$(VUSOLO4K_LIBGLES_VERSION).tar.gz
VUSOLO4K_LIBGLES_SITE = http://code.vuplus.com/download/release/libgles

$(D)/vusolo4k-libgles: | bootstrap
	$(call PREPARE)
	$(INSTALL_EXEC) $(BUILD_DIR)/libgles-vusolo4k/lib/* $(TARGET_LIB_DIR)
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	cp -a $(BUILD_DIR)/libgles-vusolo4k/include/* $(TARGET_INCLUDE_DIR)
	$(call TARGET_FOLLOWUP)

################################################################################
#
# vusolo4k-platform-util
#
################################################################################

VUSOLO4K_PLATFORM_UTIL_DATE = $(VUSOLO4K_DRIVER_DATE)
VUSOLO4K_PLATFORM_UTIL_REV = r0
VUSOLO4K_PLATFORM_UTIL_VERSION = 17.1-$(VUSOLO4K_PLATFORM_UTIL_DATE).$(VUSOLO4K_PLATFORM_UTIL_REV)
VUSOLO4K_PLATFORM_UTIL_DIR = platform-util-vusolo4k
VUSOLO4K_PLATFORM_UTIL_SOURCE = platform-util-vusolo4k-$(VUSOLO4K_PLATFORM_UTIL_VERSION).tar.gz
VUSOLO4K_PLATFORM_UTIL_SITE = http://code.vuplus.com/download/release/platform-util

define VUSOLO4K_PLATFORM_UTIL_INSTALL_FILES
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-platform-util $(TARGET_DIR)/etc/init.d/vuplus-platform-util
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-shutdown $(TARGET_DIR)/etc/init.d/vuplus-shutdown
endef
VUSOLO4K_PLATFORM_UTIL_POST_FOLLOWUP_HOOKS += VUSOLO4K_PLATFORM_UTIL_INSTALL_FILES

define VUSOLO4K_PLATFORM_UTIL_INSTALL_INIT_SYSV
	$(UPDATE-RC.D) vuplus-platform-util start 65 S . stop 90 0 .
	$(UPDATE-RC.D) vuplus-shutdown start 89 0 .
endef

$(D)/vusolo4k-platform-util: | bootstrap
	$(call PREPARE)
	$(INSTALL_EXEC) $(BUILD_DIR)/platform-util-vusolo4k/* $(TARGET_BIN_DIR)
	$(call TARGET_FOLLOWUP)

################################################################################
#
# vusolo4k-vmlinuz-initrd 7366c0
#
################################################################################

ifeq ($(VU_MULTIBOOT),multi)
VUSOLO4K_VMLINUZ_INITRD_DATE = 20190911
VUSOLO4K_VMLINUZ_INITRD_SITE = https://bitbucket.org/max_10/vmlinuz-initrd-vusolo4k/downloads
else
VUSOLO4K_VMLINUZ_INITRD_DATE = 20170209
VUSOLO4K_VMLINUZ_INITRD_SITE = http://code.vuplus.com/download/release/kernel
endif
VUSOLO4K_VMLINUZ_INITRD_VERSION = $(VUSOLO4K_VMLINUZ_INITRD_DATE)
VUSOLO4K_VMLINUZ_INITRD_SOURCE  = vmlinuz-initrd_vusolo4k_$(VUSOLO4K_VMLINUZ_INITRD_VERSION).tar.gz

$(D)/vusolo4k-vmlinuz-initrd: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(call TARGET_FOLLOWUP)
