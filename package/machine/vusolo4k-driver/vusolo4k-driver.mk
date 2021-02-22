#
# vusolo4k-driver
#
VUSOLO4K_DRIVER_DATE   = 20190424
VUSOLO4K_DRIVER_REV    = r0
VUSOLO4K_DRIVER_VER    = 3.14.28-$(VUSOLO4K_DRIVER_DATE).$(VUSOLO4K_DRIVER_REV)
VUSOLO4K_DRIVER_SOURCE = vuplus-dvb-proxy-vusolo4k-$(VUSOLO4K_DRIVER_VER).tar.gz
VUSOLO4K_DRIVER_SITE   = http://archive.vuplus.com/download/build_support/vuplus
VUSOLO4K_DRIVER_DEPS   = bootstrap

$(D)/vusolo4k-driver:
	$(START_BUILD)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	$(TOUCH)
