#
# hd60-driver
#
HD60_DRIVER_DATE   = 20200731
HD60_DRIVER_VER    = 4.4.35
HD60_DRIVER_SOURCE = hd60-drivers-$(HD60_DRIVER_VER)-$(HD60_DRIVER_DATE).zip
HD60_DRIVER_SITE   = http://source.mynonpublic.com/gfutures
HD60_DRIVER_DEPS   = bootstrap

$(D)/hd60-driver:
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	rm -f $(TARGET_MODULES_DIR)/extra/hi_play.ko
	mv $(TARGET_MODULES_DIR)/extra/turnoff_power $(TARGET_DIR)/$(bindir)
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in hd60_1 hd60_2 hd60_3 hd60_4; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/_hd60.conf; \
	done
	$(TOUCH)
