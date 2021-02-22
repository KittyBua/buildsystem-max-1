#
# zgemma h7-libgles
#
H7_LIBGLES_DATE   = 20191110
H7_LIBGLES_VER    = $(H7_LIBGLES_DATE)
H7_LIBGLES_SOURCE = h7-v3ddriver-$(H7_LIBGLES_VER).zip
H7_LIBGLES_SITE   = http://source.mynonpublic.com/zgemma
H7_LIBGLES_DEPS   = bootstrap

$(D)/h7-libgles:
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(TARGET_LIB_DIR))
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	$(TOUCH)
