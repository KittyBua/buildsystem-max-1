################################################################################
#
# hd61-libgles
#
################################################################################

HD61_LIBGLES_DATE = 20181201
HD61_LIBGLES_VERSION = $(HD61_LIBGLES_DATE)
HD61_LIBGLES_SOURCE = hd61-mali-$(HD61_LIBGLES_VERSION).zip
HD61_LIBGLES_SITE = http://downloads.mutant-digital.net/hd61

$(D)/hd61-libgles: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(TARGET_LIB_DIR))
	(cd $(TARGET_LIB_DIR) && ln -sf libMali.so libmali.so)
	(cd $(TARGET_LIB_DIR) && ln -sf libMali.so libEGL.so.1.4 && ln -sf libEGL.so.1.4 libEGL.so.1 && ln -sf libEGL.so.1 libEGL.so)
	(cd $(TARGET_LIB_DIR) && ln -sf libMali.so libGLESv1_CM.so.1.1 && ln -sf libGLESv1_CM.so.1.1 libGLESv1_CM.so.1 && ln -sf libGLESv1_CM.so.1 libGLESv1_CM.so)
	(cd $(TARGET_LIB_DIR) && ln -sf libMali.so libGLESv2.so.2.0 && ln -sf libGLESv2.so.2.0 libGLESv2.so.2  && ln -sf libGLESv2.so.2 libGLESv2.so)
	(cd $(TARGET_LIB_DIR) && ln -sf libMali.so libgbm.so)
	cp $(PKG_FILES_DIR)/* $(TARGET_LIB_DIR)/pkgconfig
	$(call TARGET_FOLLOWUP)
