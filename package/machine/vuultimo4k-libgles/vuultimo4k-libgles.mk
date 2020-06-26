#
# vuultimo4k-libgles
#
VUULTIMO4K_LIBGLES_DATE   = $(VUULTIMO4K_DRIVER_DATE)
VUULTIMO4K_LIBGLES_REV    = r0
VUULTIMO4K_LIBGLES_VER    = 17.1-$(VUULTIMO4K_LIBGLES_DATE).$(VUULTIMO4K_LIBGLES_REV)
VUULTIMO4K_LIBGLES_SOURCE = libgles-vuultimo4k-$(VUULTIMO4K_LIBGLES_VER).tar.gz
VUULTIMO4K_LIBGLES_SITE   = http://archive.vuplus.com/download/build_support/vuplus

$(D)/vuultimo4k-libgles: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/libgles-vuultimo4k
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(INSTALL_EXEC) $(BUILD_DIR)/libgles-vuultimo4k/lib/* $(TARGET_LIB_DIR)
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	cp -a $(BUILD_DIR)/libgles-vuultimo4k/include/* $(TARGET_INCLUDE_DIR)
	$(REMOVE)/libgles-vuultimo4k
	$(TOUCH)
