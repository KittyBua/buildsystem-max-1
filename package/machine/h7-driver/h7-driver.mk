#
# zgemma h7-driver
#
H7_DRIVER_DATE    = 20191123
H7_DRIVER_VERSION = 4.10.12-$(H7_DRIVER_DATE)
H7_DRIVER_SOURCE  = h7-drivers-$(H7_DRIVER_VERSION).zip
H7_DRIVER_SITE    = http://source.mynonpublic.com/zgemma
H7_DRIVER_DEPENDS = bootstrap

h7-driver:
	$(START_BUILD)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in h7_1 h7_2 h7_3 h7_4; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/_zgemmah7.conf; \
	done
	$(TOUCH)
