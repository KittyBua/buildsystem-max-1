#
# vusolo4k-libgles
#
VUSOLO4K_LIBGLES_DATE   = $(VUSOLO4K_DRIVER_DATE)
VUSOLO4K_LIBGLES_REV    = r0
VUSOLO4K_LIBGLES_VER    = 17.1-$(VUSOLO4K_LIBGLES_DATE).$(VUSOLO4K_LIBGLES_REV)
VUSOLO4K_LIBGLES_SOURCE = libgles-vusolo4k-$(VUSOLO4K_LIBGLES_VER).tar.gz
VUSOLO4K_LIBGLES_SITE   = http://archive.vuplus.com/download/build_support/vuplus

$(D)/vusolo4k-libgles: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/libgles-vusolo4k
	$(UNTAR)/$(PKG_SOURCE)
	$(INSTALL_EXEC) $(BUILD_DIR)/libgles-vusolo4k/lib/* $(TARGET_DIR)/usr/lib
	ln -sf libv3ddriver.so $(TARGET_DIR)/usr/lib/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_DIR)/usr/lib/libGLESv2.so
	cp -a $(BUILD_DIR)/libgles-vusolo4k/include/* $(TARGET_DIR)/usr/include
	$(REMOVE)/libgles-vusolo4k
	$(TOUCH)
