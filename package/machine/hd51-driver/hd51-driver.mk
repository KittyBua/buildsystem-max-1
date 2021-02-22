#
# hd51-driver
#
HD51_DRIVER_DATE   = 20191120
HD51_DRIVER_VER    = 4.10.12-$(HD51_DRIVER_DATE)
HD51_DRIVER_SOURCE = hd51-drivers-$(HD51_DRIVER_VER).zip
HD51_DRIVER_SITE   = http://source.mynonpublic.com/gfutures
HD51_DRIVER_DEPS   = bootstrap

$(D)/hd51-driver:
	$(START_BUILD)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in hd51_1 hd51_2 hd51_3 hd51_4; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/_hd51.conf; \
	done
	$(TOUCH)
