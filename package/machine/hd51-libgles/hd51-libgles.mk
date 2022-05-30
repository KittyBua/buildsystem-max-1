################################################################################
#
# hd51-libgles
#
################################################################################

HD51_LIBGLES_DATE    = 20191101
HD51_LIBGLES_VERSION = $(HD51_LIBGLES_DATE)
HD51_LIBGLES_SOURCE  = hd51-v3ddriver-$(HD51_LIBGLES_VERSION).zip
HD51_LIBGLES_SITE    = http://downloads.mutant-digital.net/v3ddriver
HD51_LIBGLES_DEPENDS = bootstrap

$(D)/hd51-libgles:
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(TARGET_LIB_DIR))
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	$(call TARGET_FOLLOWUP)
