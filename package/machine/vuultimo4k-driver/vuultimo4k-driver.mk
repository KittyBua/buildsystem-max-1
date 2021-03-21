#
# vuultimo4k-driver
#
VUULTIMO4K_DRIVER_DATE    = 20190424
VUULTIMO4K_DRIVER_REV     = r0
VUULTIMO4K_DRIVER_VERSION = 3.14.28-$(VUULTIMO4K_DRIVER_DATE).$(VUULTIMO4K_DRIVER_REV)
VUULTIMO4K_DRIVER_SOURCE  = vuplus-dvb-proxy-vuultimo4k-$(VUULTIMO4K_DRIVER_VERSION).tar.gz
VUULTIMO4K_DRIVER_SITE    = http://code.vuplus.com/download/release/vuplus-dvb-proxy
VUULTIMO4K_DRIVER_DEPENDS = bootstrap

$(D)/vuultimo4k-driver:
	$(START_BUILD)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	$(TOUCH)
