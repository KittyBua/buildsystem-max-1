################################################################################
#
# vuzero4k-libgles
#
################################################################################

VUZERO4K_LIBGLES_DATE = $(VUZERO4K_DRIVER_DATE)
VUZERO4K_LIBGLES_REV = r0
VUZERO4K_LIBGLES_VERSION = 17.1-$(VUZERO4K_LIBGLES_DATE).$(VUZERO4K_LIBGLES_REV)
VUZERO4K_LIBGLES_DIR = libgles-vuzero4k
VUZERO4K_LIBGLES_SOURCE = libgles-vuzero4k-$(VUZERO4K_LIBGLES_VERSION).tar.gz
VUZERO4K_LIBGLES_SITE = http://code.vuplus.com/download/release/libgles

$(D)/vuzero4k-libgles: | bootstrap
	$(call PREPARE)
	$(INSTALL_EXEC) $(BUILD_DIR)/libgles-vuzero4k/lib/* $(TARGET_LIB_DIR)
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	cp -a $(BUILD_DIR)/libgles-vuzero4k/include/* $(TARGET_INCLUDE_DIR)
	$(call TARGET_FOLLOWUP)
