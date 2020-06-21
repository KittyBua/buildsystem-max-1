#
# bre2ze4k-libgles
#
BRE2ZE4K_LIBGLES_DATE   = 20191101
BRE2ZE4K_LIBGLES_VER    = $(BRE2ZE4K_LIBGLES_DATE)
BRE2ZE4K_LIBGLES_SOURCE = bre2ze4k-v3ddriver-$(BRE2ZE4K_LIBGLES_VER).zip
BRE2ZE4K_LIBGLES_SITE   = http://downloads.mutant-digital.net/v3ddriver

$(D)/bre2ze4k-libgles: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	unzip -o $(SILENT_Q) $(DL_DIR)/$(PKG_SOURCE) -d $(TARGET_DIR)/usr/lib/
	ln -sf libv3ddriver.so $(TARGET_DIR)/usr/lib/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_DIR)/usr/lib/libGLESv2.so
	$(TOUCH)
