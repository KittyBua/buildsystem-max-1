#
# hd60-libgles
#
HD60_LIBGLES_DATE    = 20181201
HD60_LIBGLES_VERSION = $(HD60_LIBGLES_DATE)
HD60_LIBGLES_SOURCE  = hd60-mali-$(HD60_LIBGLES_VERSION).zip
HD60_LIBGLES_SITE    = http://downloads.mutant-digital.net/hd60
HD60_LIBGLES_DEPENDS = bootstrap

hd60-libgles:
	$(START_BUILD)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(TARGET_LIB_DIR))
	(cd $(TARGET_LIB_DIR) && ln -sf libMali.so libmali.so)
	(cd $(TARGET_LIB_DIR) && ln -sf libMali.so libEGL.so.1.4 && ln -sf libEGL.so.1.4 libEGL.so.1 && ln -sf libEGL.so.1 libEGL.so)
	(cd $(TARGET_LIB_DIR) && ln -sf libMali.so libGLESv1_CM.so.1.1 && ln -sf libGLESv1_CM.so.1.1 libGLESv1_CM.so.1 && ln -sf libGLESv1_CM.so.1 libGLESv1_CM.so)
	(cd $(TARGET_LIB_DIR) && ln -sf libMali.so libGLESv2.so.2.0 && ln -sf libGLESv2.so.2.0 libGLESv2.so.2  && ln -sf libGLESv2.so.2 libGLESv2.so)
	(cd $(TARGET_LIB_DIR) && ln -sf libMali.so libgbm.so)
	cp $(PKG_FILES_DIR)/* $(TARGET_LIB_DIR)/pkgconfig
	$(TOUCH)
