################################################################################
#
# bre2ze4k-libgles
#
################################################################################

BRE2ZE4K_LIBGLES_DATE    = 20191101
BRE2ZE4K_LIBGLES_VERSION = $(BRE2ZE4K_LIBGLES_DATE)
BRE2ZE4K_LIBGLES_SOURCE  = bre2ze4k-v3ddriver-$(BRE2ZE4K_LIBGLES_VERSION).zip
BRE2ZE4K_LIBGLES_SITE    = http://downloads.mutant-digital.net/v3ddriver
BRE2ZE4K_LIBGLES_DEPENDS = bootstrap

$(D)/bre2ze4k-libgles:
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(TARGET_LIB_DIR))
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	$(call TARGET_FOLLOWUP)
