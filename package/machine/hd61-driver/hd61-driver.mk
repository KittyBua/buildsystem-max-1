#
# hd61-driver
#
HD61_DRIVER_DATE    = 20200731
HD61_DRIVER_VERSION = 4.4.35
HD61_DRIVER_SOURCE  = hd61-drivers-$(HD61_DRIVER_VERSION)-$(HD61_DRIVER_DATE).zip
HD61_DRIVER_SITE    = http://source.mynonpublic.com/gfutures
HD61_DRIVER_DEPENDS = bootstrap

hd61-driver:
	$(START_BUILD)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	rm -f $(TARGET_MODULES_DIR)/extra/hi_play.ko
	mkdir -p $(TARGET_DIR)/bin
	mv $(TARGET_MODULES_DIR)/extra/turnoff_power $(TARGET_DIR)/$(bindir)
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in hd61_1 hd61_2 hd61_3 hd61_4; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/_hd61.conf; \
	done
	$(TOUCH)
