################################################################################
#
# vuduo-driver
#
################################################################################

VUDUO_DRIVER_DATE = 20151124
VUDUO_DRIVER_VERSION = 3.9.6-$(VUDUO_DRIVER_DATE)
VUDUO_DRIVER_SOURCE = vuplus-dvb-modules-bm750-$(VUDUO_DRIVER_VERSION).tar.gz
VUDUO_DRIVER_SITE = http://code.vuplus.com/download/release/vuplus-dvb-modules

$(D)/vuduo-driver: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in brcmfb dvb-bcm7335 procmk; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/_vuduo.conf; \
	done
	$(call TARGET_FOLLOWUP)
