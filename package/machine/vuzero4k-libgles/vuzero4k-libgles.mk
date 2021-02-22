#
# vuzero4k-libgles
#
VUZERO4K_LIBGLES_DATE   = $(VUZERO4K_DRIVER_DATE)
VUZERO4K_LIBGLES_REV    = r0
VUZERO4K_LIBGLES_VER    = 17.1-$(VUZERO4K_LIBGLES_DATE).$(VUZERO4K_LIBGLES_REV)
VUZERO4K_LIBGLES_DIR    = libgles-vuzero4k
VUZERO4K_LIBGLES_SOURCE = libgles-vuzero4k-$(VUZERO4K_LIBGLES_VER).tar.gz
VUZERO4K_LIBGLES_SITE   = http://archive.vuplus.com/download/build_support/vuplus
VUZERO4K_LIBGLES_DEPS   = bootstrap

$(D)/vuzero4k-libgles:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(INSTALL_EXEC) $(BUILD_DIR)/libgles-vuzero4k/lib/* $(TARGET_LIB_DIR)
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	cp -a $(BUILD_DIR)/libgles-vuzero4k/include/* $(TARGET_INCLUDE_DIR)
	$(REMOVE)
	$(TOUCH)
