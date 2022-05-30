################################################################################
#
# zgemma h7-libgles
#
################################################################################

H7_LIBGLES_DATE    = 20191110
H7_LIBGLES_VERSION = $(H7_LIBGLES_DATE)
H7_LIBGLES_SOURCE  = h7-v3ddriver-$(H7_LIBGLES_VERSION).zip
H7_LIBGLES_SITE    = http://source.mynonpublic.com/zgemma
H7_LIBGLES_DEPENDS = bootstrap

$(D)/h7-libgles:
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(TARGET_LIB_DIR))
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	$(call TARGET_FOLLOWUP)
