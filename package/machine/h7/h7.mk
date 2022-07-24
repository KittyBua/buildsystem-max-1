################################################################################
#
# zgemma h7-driver
#
################################################################################

H7_DRIVER_DATE = 20191123
H7_DRIVER_VERSION = 4.10.12-$(H7_DRIVER_DATE)
H7_DRIVER_SOURCE = h7-drivers-$(H7_DRIVER_VERSION).zip
H7_DRIVER_SITE = http://source.mynonpublic.com/zgemma

$(D)/h7-driver: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in h7_1 h7_2 h7_3 h7_4; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/_zgemmah7.conf; \
	done
	$(call TARGET_FOLLOWUP)

################################################################################
#
# zgemma h7-libgles
#
################################################################################

H7_LIBGLES_DATE = 20191110
H7_LIBGLES_VERSION = $(H7_LIBGLES_DATE)
H7_LIBGLES_SOURCE = h7-v3ddriver-$(H7_LIBGLES_VERSION).zip
H7_LIBGLES_SITE = http://source.mynonpublic.com/zgemma

$(D)/h7-libgles: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(TARGET_LIB_DIR))
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	$(call TARGET_FOLLOWUP)
