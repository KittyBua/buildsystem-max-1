#
# vuduo4k-driver
#
VUDUO4K_DRIVER_DATE   = 20191218
VUDUO4K_DRIVER_REV    = r0
VUDUO4K_DRIVER_VER    = 4.1.45-$(VUDUO4K_DRIVER_DATE).$(VUDUO4K_DRIVER_REV)
VUDUO4K_DRIVER_SOURCE = vuplus-dvb-proxy-vuduo4k-$(VUDUO4K_DRIVER_VER).tar.gz
VUDUO4K_DRIVER_SITE   = http://archive.vuplus.com/download/build_support/vuplus
VUDUO4K_DRIVER_DEPS   = bootstrap

$(D)/vuduo4k-driver:
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	$(TOUCH)
