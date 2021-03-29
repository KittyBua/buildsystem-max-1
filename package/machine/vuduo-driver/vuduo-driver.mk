#
# vuduo-driver
#
VUDUO_DRIVER_DATE    = 20151124
VUDUO_DRIVER_VERSION = 3.9.6-$(VUDUO_DRIVER_DATE)
VUDUO_DRIVER_SOURCE  = vuplus-dvb-modules-bm750-$(VUDUO_DRIVER_VERSION).tar.gz
VUDUO_DRIVER_SITE    = http://code.vuplus.com/download/release/vuplus-dvb-modules
VUDUO_DRIVER_DEPENDS = bootstrap

vuduo-driver:
	$(START_BUILD)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in brcmfb dvb-bcm7335 procmk; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/_vuduo.conf; \
	done
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-shutdown $(TARGET_DIR)/etc/init.d/vuplus-shutdown
	$(UPDATE-RC.D) vuplus-shutdown start 89 0 .
	$(TOUCH)
