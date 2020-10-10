#
# vuduo4kse-driver
#
VUDUO4KSE_DRIVER_DATE   = 20200903
VUDUO4KSE_DRIVER_REV    = r0
VUDUO4KSE_DRIVER_VER    = 4.1.45-$(VUDUO4KSE_DRIVER_DATE).$(VUDUO4KSE_DRIVER_REV)
VUDUO4KSE_DRIVER_SOURCE = vuplus-dvb-proxy-vuduo4kse-$(VUDUO4KSE_DRIVER_VER).tar.gz
VUDUO4KSE_DRIVER_SITE   = http://archive.vuplus.com/download/build_support/vuplus

$(D)/vuduo4kse-driver: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call PKG_UNPACK,$(TARGET_MODULES_DIR)/extra)
	$(TOUCH)
