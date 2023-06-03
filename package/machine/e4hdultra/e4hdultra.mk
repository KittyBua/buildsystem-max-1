################################################################################
#
# e4hdultra-driver
#
################################################################################

E4HDULTRA_DRIVER_DATE = 20191101
E4HDULTRA_DRIVER_VERSION = 4.10.12-$(E4HDULTRA_DRIVER_DATE)
E4HDULTRA_DRIVER_SOURCE = e4hd-drivers-$(E4HDULTRA_DRIVER_VERSION).zip
E4HDULTRA_DRIVER_SITE = http://source.mynonpublic.com/ceryon

$(D)/e4hdultra-driver: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD-PACKAGE)
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in e4hd_1 e4hd_2 e4hd_3 e4hd_4; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/_e4hd.conf; \
	done
	$(call TARGET_FOLLOWUP)

################################################################################
#
# e4hdultra-libgles
#
################################################################################

E4HDULTRA_LIBGLES_DATE = 20191101
E4HDULTRA_LIBGLES_VERSION = $(E4HDULTRA_LIBGLES_DATE)
E4HDULTRA_LIBGLES_SOURCE = 8100s-v3ddriver-$(E4HDULTRA_LIBGLES_VERSION).zip
E4HDULTRA_LIBGLES_SITE = https://source.mynonpublic.com/ceryon

$(D)/e4hdultra-libgles: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD-PACKAGE)
	$(call EXTRACT,$(TARGET_LIB_DIR))
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libEGL.so
	ln -sf libv3ddriver.so $(TARGET_LIB_DIR)/libGLESv2.so
	$(call TARGET_FOLLOWUP)
