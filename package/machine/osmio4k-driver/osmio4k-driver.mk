#
# osmio4k-driver
#
OSMIO4K_DRIVER_DATE   = 20191010
OSMIO4K_DRIVER_VER    = 5.3.0-$(OSMIO4K_DRIVER_DATE)
OSMIO4K_DRIVER_SOURCE = osmio4k-drivers-$(OSMIO4K_DRIVER_VER).zip
OSMIO4K_DRIVER_SITE   = http://source.mynonpublic.com/edision

$(D)/osmio4k-driver: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call PKG_UNPACK,$(TARGET_MODULES_DIR)/extra)
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in brcmstb-osmio4k ci si2183 avl6862 avl6261; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/_osmio4k.conf; \
	done
	make depmod
	$(TOUCH)
	make osmio4k-libgles
	make osmio4k-wlan-qcom
