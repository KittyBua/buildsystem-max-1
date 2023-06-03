################################################################################
#
# osmio4kplus-driver
#
################################################################################

OSMIO4KPLUS_DRIVER_DATE = 20201013
OSMIO4KPLUS_DRIVER_VERSION = 5.9.0-$(OSMIO4KPLUS_DRIVER_DATE)
OSMIO4KPLUS_DRIVER_SOURCE = osmio4kplus-drivers-$(OSMIO4KPLUS_DRIVER_VERSION).zip
OSMIO4KPLUS_DRIVER_SITE = http://source.mynonpublic.com/edision

$(D)/osmio4kplus-driver: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD-PACKAGE)
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in brcmstb-osmio4kplus brcmstb-decoder ci si2183 avl6862 avl6261; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/_osmio4kplus.conf; \
	done
	$(call TARGET_FOLLOWUP)

################################################################################
#
# osmio4kplus-libgles
#
################################################################################

OSMIO4KPLUS_LIBGLES_VERSION = 2.0
OSMIO4KPLUS_LIBGLES_DIR = edision-libv3d-$(OSMIO4KPLUS_LIBGLES_VERSION)
OSMIO4KPLUS_LIBGLES_SOURCE = edision-libv3d-$(OSMIO4KPLUS_LIBGLES_VERSION).tar.xz
OSMIO4KPLUS_LIBGLES_SITE = http://source.mynonpublic.com/edision

$(D)/osmio4kplus-libgles: | bootstrap
	$(call PREPARE)
	cp -a $(PKG_BUILD_DIR)/lib/* $(TARGET_LIB_DIR)
	ln -sf libv3ddriver.so.$(OSMIO4KPLUS_LIBGLES_VERSION) $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so.$(OSMIO4KPLUS_LIBGLES_VERSION) $(TARGET_LIB_DIR)/libGLESv2.so
	install -m 0644 $(PKG_BUILD_DIR)/include/v3dplatform.h $(TARGET_INCLUDE_DIR)
	for d in EGL GLES GLES2 GLES3 KHR; do \
		install -m 0755 -d $(TARGET_INCLUDE_DIR)/$$d; \
		for f in $(PKG_BUILD_DIR)/include/$$d/*.h; do \
			install -m 0644 $$f $(TARGET_INCLUDE_DIR)/$$d; \
		done; \
	done
	$(call TARGET_FOLLOWUP)
