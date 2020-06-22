#
# hd51-libgles
#
HD51_LIBGLES_DATE   = 20191101
HD51_LIBGLES_VER    = $(HD51_LIBGLES_DATE)
HD51_LIBGLES_SOURCE = hd51-v3ddriver-$(HD51_LIBGLES_VER).zip
HD51_LIBGLES_SITE   = http://downloads.mutant-digital.net/v3ddriver

$(D)/hd51-libgles: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(TARGET_LIB_DIR))
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	$(TOUCH)
