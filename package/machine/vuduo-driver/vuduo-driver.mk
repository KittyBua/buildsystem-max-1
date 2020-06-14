#
# vuduo-driver
#
VUDUO_DRIVER_DATE   = 20151124
VUDUO_DRIVER_VER    = 3.9.6-$(VUDUO_DRIVER_DATE)
VUDUO_DRIVER_SOURCE = vuplus-dvb-modules-bm750-$(VUDUO_DRIVER_VER).tar.gz
VUDUO_DRIVER_URL    = http://archive.vuplus.com/download/drivers

$(D)/vuduo-driver: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	mkdir -p $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra
	tar -xf $(DL_DIR)/$(PKG_SOURCE) -C $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in brcmfb dvb-bcm7335 procmk; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/_vuduo.conf; \
	done
	make depmod
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/vuplus-shutdown $(TARGET_DIR)/etc/init.d/vuplus-shutdown
	$(UPDATE-RC.D) vuplus-shutdown start 89 0 .
	$(TOUCH)
