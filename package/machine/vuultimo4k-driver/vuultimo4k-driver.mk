#
# vuultimo4k-driver
#
VUULTIMO4K_DRIVER_DATE   = 20190104
VUULTIMO4K_DRIVER_REV    = r0
VUULTIMO4K_DRIVER_VER    = 3.14.28-$(VUULTIMO4K_DRIVER_DATE).$(VUULTIMO4K_DRIVER_REV)
VUULTIMO4K_DRIVER_SOURCE = vuplus-dvb-proxy-vuultimo4k-$(VUULTIMO4K_DRIVER_VER).tar.gz
VUULTIMO4K_DRIVER_SITE   = http://archive.vuplus.com/download/build_support/vuplus

$(D)/vuultimo4k-driver: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call PKG_UNPACK,$(TARGET_MODULES_DIR)/extra)
	$(TOUCH)
