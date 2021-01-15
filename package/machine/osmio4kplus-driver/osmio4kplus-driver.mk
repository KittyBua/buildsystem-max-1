#
# osmio4kplus-driver
#
OSMIO4KPLUS_DRIVER_DATE   = 20201013
OSMIO4KPLUS_DRIVER_VER    = 5.9.0-$(OSMIO4KPLUS_DRIVER_DATE)
OSMIO4KPLUS_DRIVER_SOURCE = osmio4kplus-drivers-$(OSMIO4KPLUS_DRIVER_VER).zip
OSMIO4KPLUS_DRIVER_SITE   = http://source.mynonpublic.com/edision
OSMIO4KPLUS_DRIVER_DEPS   = bootstrap

$(D)/osmio4kplus-driver:
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call PKG_UNPACK,$(TARGET_MODULES_DIR)/extra)
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in brcmstb-osmio4kplus brcmstb-decoder ci si2183 avl6862 avl6261; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/_osmio4kplus.conf; \
	done
	$(TOUCH)
