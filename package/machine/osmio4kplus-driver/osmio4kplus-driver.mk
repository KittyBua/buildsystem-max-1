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
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in brcmstb-osmio4kplus brcmstb-decoder ci si2183 avl6862 avl6261; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/_osmio4kplus.conf; \
	done
	$(call TARGET_FOLLOWUP)
