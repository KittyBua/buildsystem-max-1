#
# zgemma h7-libgles
#
H7_LIBGLES_DATE   = 20191110
H7_LIBGLES_VER    = $(H7_LIBGLES_DATE)
H7_LIBGLES_SOURCE = h7-v3ddriver-$(H7_LIBGLES_VER).zip
H7_LIBGLES_SITE   = http://source.mynonpublic.com/zgemma

$(D)/h7-libgles: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	unzip -o $(SILENT_Q) $(DL_DIR)/$(PKG_SOURCE) -d $(TARGET_DIR)/usr/lib/
	ln -sf libv3ddriver.so $(TARGET_DIR)/usr/lib/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_DIR)/usr/lib/libGLESv2.so
	$(TOUCH)
