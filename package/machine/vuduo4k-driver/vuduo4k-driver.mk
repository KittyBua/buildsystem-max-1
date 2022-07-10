################################################################################
#
# vuduo4k-driver
#
################################################################################

VUDUO4K_DRIVER_DATE = 20191218
VUDUO4K_DRIVER_REV = r0
VUDUO4K_DRIVER_VERSION = 4.1.45-$(VUDUO4K_DRIVER_DATE).$(VUDUO4K_DRIVER_REV)
VUDUO4K_DRIVER_SOURCE = vuplus-dvb-proxy-vuduo4k-$(VUDUO4K_DRIVER_VERSION).tar.gz
VUDUO4K_DRIVER_SITE = http://code.vuplus.com/download/release/vuplus-dvb-proxy

$(D)/vuduo4k-driver: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	$(call TARGET_FOLLOWUP)
