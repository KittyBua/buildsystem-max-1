#
# osmio4k-libgles
#
OSMIO4K_LIBGLES_VER    = 1.0
OSMIO4K_LIBGLES_DIR    = libv3d-osmio4k-$(OSMIO4K_LIBGLES_VER)
OSMIO4K_LIBGLES_SOURCE = libv3d-osmio4k-$(OSMIO4K_LIBGLES_VER).tar.xz
OSMIO4K_LIBGLES_URL    = http://source.mynonpublic.com/edision

$(D)/osmio4k-libgles: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	cp -a $(PKG_BUILD_DIR)/* $(TARGET_DIR)/usr/
	ln -sf libv3ddriver.so.1.0 $(TARGET_DIR)/usr/lib/libEGL.so
	ln -sf libv3ddriver.so.1.0 $(TARGET_DIR)/usr/lib/libGLESv2.so
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
