################################################################################
#
# bre2ze4k-driver
#
################################################################################

BRE2ZE4K_DRIVER_DATE = 20191120
BRE2ZE4K_DRIVER_VERSION = 4.10.12-$(BRE2ZE4K_DRIVER_DATE)
BRE2ZE4K_DRIVER_SOURCE = bre2ze4k-drivers-$(BRE2ZE4K_DRIVER_VERSION).zip
BRE2ZE4K_DRIVER_SITE = http://source.mynonpublic.com/gfutures

$(D)/bre2ze4k-driver: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in bre2ze4k_1 bre2ze4k_2 bre2ze4k_3 bre2ze4k_4; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/_bre2ze4k.conf; \
	done
	$(call TARGET_FOLLOWUP)
