#
# vuzero4k-driver
#
VUZERO4K_DRIVER_DATE    = 20190424
VUZERO4K_DRIVER_REV     = r0
VUZERO4K_DRIVER_VERSION = 4.1.20-$(VUZERO4K_DRIVER_DATE).$(VUZERO4K_DRIVER_REV)
VUZERO4K_DRIVER_SOURCE  = vuplus-dvb-proxy-vuzero4k-$(VUZERO4K_DRIVER_VERSION).tar.gz
VUZERO4K_DRIVER_SITE    = http://code.vuplus.com/download/release/vuplus-dvb-proxy
VUZERO4K_DRIVER_DEPENDS = bootstrap

vuzero4k-driver:
	$(START_BUILD)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	$(TOUCH)
