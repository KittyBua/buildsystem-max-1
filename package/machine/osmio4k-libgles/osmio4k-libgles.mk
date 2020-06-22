#
# osmio4k-libgles
#
OSMIO4K_LIBGLES_VER    = 1.0
OSMIO4K_LIBGLES_DIR    = libv3d-osmio4k-$(OSMIO4K_LIBGLES_VER)
OSMIO4K_LIBGLES_SOURCE = libv3d-osmio4k-$(OSMIO4K_LIBGLES_VER).tar.xz
OSMIO4K_LIBGLES_SITE   = http://source.mynonpublic.com/edision

$(D)/osmio4k-libgles: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	cp -a $(PKG_BUILD_DIR)/* $(TARGET_DIR)/usr/
	ln -sf libv3ddriver.so.1.0 $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so.1.0 $(TARGET_LIB_DIR)/libGLESv2.so
	$(PKG_REMOVE)
	$(TOUCH)
