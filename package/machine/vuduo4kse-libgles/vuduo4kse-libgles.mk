#
# vuduo4kse-libgles
#
VUDUO4KSE_LIBGLES_DATE   = 20200903
VUDUO4KSE_LIBGLES_REV    = r0
VUDUO4KSE_LIBGLES_VER    = 17.1-$(VUDUO4KSE_LIBGLES_DATE).$(VUDUO4KSE_LIBGLES_REV)
VUDUO4KSE_LIBGLES_DIR    = libgles-vuduo4kse
VUDUO4KSE_LIBGLES_SOURCE = libgles-vuduo4kse-$(VUDUO4KSE_LIBGLES_VER).tar.gz
VUDUO4KSE_LIBGLES_SITE   = http://archive.vuplus.com/download/build_support/vuplus

$(D)/vuduo4kse-libgles: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(INSTALL_EXEC) $(BUILD_DIR)/libgles-vuduo4kse/lib/* $(TARGET_LIB_DIR)
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	cp -a $(BUILD_DIR)/libgles-vuduo4kse/include/* $(TARGET_INCLUDE_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
