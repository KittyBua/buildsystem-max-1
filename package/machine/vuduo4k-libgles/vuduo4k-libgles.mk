#
# vuduo4k-libgles
#
VUDUO4K_LIBGLES_DATE   = $(VUDUO4K_DRIVER_DATE)
VUDUO4K_LIBGLES_REV    = r0
VUDUO4K_LIBGLES_VER    = 18.1-$(VUDUO4K_LIBGLES_DATE).$(VUDUO4K_LIBGLES_REV)
VUDUO4K_LIBGLES_DIR    = libgles-vuduo4k
VUDUO4K_LIBGLES_SOURCE = libgles-vuduo4k-$(VUDUO4K_LIBGLES_VER).tar.gz
VUDUO4K_LIBGLES_SITE   = http://archive.vuplus.com/download/build_support/vuplus

$(D)/vuduo4k-libgles: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(INSTALL_EXEC) $(BUILD_DIR)/libgles-vuduo4k/lib/* $(TARGET_LIB_DIR)
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	cp -a $(BUILD_DIR)/libgles-vuduo4k/include/* $(TARGET_INCLUDE_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
