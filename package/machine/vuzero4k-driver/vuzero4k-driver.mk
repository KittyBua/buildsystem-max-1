#
# vuzero4k-driver
#
VUZERO4K_DRIVER_DATE   = 20190424
VUZERO4K_DRIVER_REV    = r0
VUZERO4K_DRIVER_VER    = 4.1.20-$(VUZERO4K_DRIVER_DATE).$(VUZERO4K_DRIVER_REV)
VUZERO4K_DRIVER_SOURCE = vuplus-dvb-proxy-vuzero4k-$(VUZERO4K_DRIVER_VER).tar.gz
VUZERO4K_DRIVER_SITE   = http://archive.vuplus.com/download/build_support/vuplus
VUZERO4K_DRIVER_DEPS   = bootstrap

$(D)/vuzero4k-driver:
	$(START_BUILD)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	$(TOUCH)
