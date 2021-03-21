#
# osmio4kplus-libgles
#
OSMIO4KPLUS_LIBGLES_VERSION = 2.0
OSMIO4KPLUS_LIBGLES_DIR     = edision-libv3d-$(OSMIO4KPLUS_LIBGLES_VERSION)
OSMIO4KPLUS_LIBGLES_SOURCE  = edision-libv3d-$(OSMIO4KPLUS_LIBGLES_VERSION).tar.xz
OSMIO4KPLUS_LIBGLES_SITE    = http://source.mynonpublic.com/edision
OSMIO4KPLUS_LIBGLES_DEPENDS = bootstrap

$(D)/osmio4kplus-libgles:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	cp -a $(PKG_BUILD_DIR)/lib/* $(TARGET_DIR)/usr/lib
	ln -sf libv3ddriver.so.$(OSMIO4KPLUS_LIBGLES_VERSION) $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so.$(OSMIO4KPLUS_LIBGLES_VERSION) $(TARGET_LIB_DIR)/libGLESv2.so
	install -m 0644 $(PKG_BUILD_DIR)/include/v3dplatform.h $(TARGET_INCLUDE_DIR)
	for d in EGL GLES GLES2 GLES3 KHR; do \
		install -m 0755 -d $(TARGET_INCLUDE_DIR)/$$d; \
		for f in $(PKG_BUILD_DIR)/include/$$d/*.h; do \
			install -m 0644 $$f $(TARGET_INCLUDE_DIR)/$$d; \
		done; \
	done
	$(REMOVE)
	$(TOUCH)
