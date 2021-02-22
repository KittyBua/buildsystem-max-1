#
# osmio4k-driver
#
OSMIO4K_DRIVER_DATE   = 20201013
OSMIO4K_DRIVER_VER    = 5.9.0-$(OSMIO4K_DRIVER_DATE)
OSMIO4K_DRIVER_SOURCE = osmio4k-drivers-$(OSMIO4K_DRIVER_VER).zip
OSMIO4K_DRIVER_SITE   = http://source.mynonpublic.com/edision
OSMIO4K_DRIVER_DEPS   = bootstrap

$(D)/osmio4k-driver:
	$(START_BUILD)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in brcmstb-osmio4k brcmstb-decoder ci si2183 avl6862 avl6261; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/_osmio4k.conf; \
	done
	$(TOUCH)
