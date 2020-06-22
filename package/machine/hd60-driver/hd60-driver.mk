#
# hd60-driver
#
HD60_DRIVER_DATE   = 20190319
HD60_DRIVER_VER    = 4.4.35
HD60_DRIVER_SOURCE = hd60-drivers-$(HD60_DRIVER_VER)-$(HD60_DRIVER_DATE).zip
HD60_DRIVER_SITE   = http://downloads.mutant-digital.net/hd60

$(D)/hd60-driver: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call PKG_UNPACK,$(TARGET_MODULES_DIR)/extra)
	rm -f $(TARGET_MODULES_DIR)/extra/hi_play.ko
	mkdir -p $(TARGET_DIR)/bin
	mv $(TARGET_MODULES_DIR)/extra/turnoff_power $(TARGET_DIR)/bin
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in hd60_1 hd60_2 hd60_3 hd60_4; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/_hd60.conf; \
	done
	make depmod
	$(TOUCH)
	make hd60-libs
	make hd60-libgles
	make hd60-mali-module
