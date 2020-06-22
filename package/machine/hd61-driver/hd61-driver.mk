#
# hd61-driver
#
HD61_DRIVER_DATE   = 20190711
HD61_DRIVER_VER    = 4.4.35
HD61_DRIVER_SOURCE = hd61-drivers-$(HD61_DRIVER_VER)-$(HD61_DRIVER_DATE).zip
HD61_DRIVER_SITE   = http://downloads.mutant-digital.net/hd61

$(D)/hd61-driver: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call PKG_UNPACK,$(TARGET_MODULES_DIR)/extra)
	rm -f $(TARGET_MODULES_DIR)/extra/hi_play.ko
	mkdir -p $(TARGET_DIR)/bin
	mv $(TARGET_MODULES_DIR)/extra/turnoff_power $(TARGET_DIR)/bin
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in hd61_1 hd61_2 hd61_3 hd61_4; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/_hd61.conf; \
	done
	make depmod
	$(TOUCH)
	make hd61-libs
	make hd61-libgles
	make hd61-mali-module
