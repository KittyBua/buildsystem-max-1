################################################################################
#
# vuduo4kse-driver
#
################################################################################

VUDUO4KSE_DRIVER_DATE = 20200903
VUDUO4KSE_DRIVER_REV = r0
VUDUO4KSE_DRIVER_VERSION = 4.1.45-$(VUDUO4KSE_DRIVER_DATE).$(VUDUO4KSE_DRIVER_REV)
VUDUO4KSE_DRIVER_SOURCE = vuplus-dvb-proxy-vuduo4kse-$(VUDUO4KSE_DRIVER_VERSION).tar.gz
VUDUO4KSE_DRIVER_SITE = http://code.vuplus.com/download/release/vuplus-dvb-proxy

$(D)/vuduo4kse-driver: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	$(call TARGET_FOLLOWUP)
