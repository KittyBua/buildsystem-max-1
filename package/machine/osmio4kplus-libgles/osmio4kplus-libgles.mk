#
# osmio4kplus-libgles
#
OSMIO4KPLUS_LIBGLES_VER    = 1.0
OSMIO4KPLUS_LIBGLES_DIR    = libv3d-osmio4k-$(OSMIO4KPLUS_LIBGLES_VER)
OSMIO4KPLUS_LIBGLES_SOURCE = libv3d-osmio4kplus-$(OSMIO4KPLUS_LIBGLES_VER).tar.xz
OSMIO4KPLUS_LIBGLES_SITE   = http://source.mynonpublic.com/edision

$(D)/osmio4kplus-libgles: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	cp -a $(subst plus-,-,$(PKG_BUILD_DIR))/* $(TARGET_DIR)/usr/
	ln -sf libv3ddriver.so.1.0 $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so.1.0 $(TARGET_LIB_DIR)/libGLESv2.so
	$(PKG_REMOVE)
	$(TOUCH)
