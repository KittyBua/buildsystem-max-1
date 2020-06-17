#
# hd51-libgles
#
HD51_LIBGLES_DATE   = 20191101
HD51_LIBGLES_VER    = $(HD51_LIBGLES_DATE)
HD51_LIBGLES_SOURCE = hd51-v3ddriver-$(HD51_LIBGLES_VER).zip
HD51_LIBGLES_SITE   = http://downloads.mutant-digital.net/v3ddriver

$(D)/hd51-libgles: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	unzip -o $(SILENT_Q) $(DL_DIR)/$(PKG_SOURCE) -d $(TARGET_DIR)/usr/lib/
	ln -sf libv3ddriver.so $(TARGET_DIR)/usr/lib/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_DIR)/usr/lib/libGLESv2.so
	$(TOUCH)
