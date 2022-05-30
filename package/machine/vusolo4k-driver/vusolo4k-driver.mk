################################################################################
#
# vusolo4k-driver
#
################################################################################

VUSOLO4K_DRIVER_DATE    = 20190424
VUSOLO4K_DRIVER_REV     = r0
VUSOLO4K_DRIVER_VERSION = 3.14.28-$(VUSOLO4K_DRIVER_DATE).$(VUSOLO4K_DRIVER_REV)
VUSOLO4K_DRIVER_SOURCE  = vuplus-dvb-proxy-vusolo4k-$(VUSOLO4K_DRIVER_VERSION).tar.gz
VUSOLO4K_DRIVER_SITE    = http://code.vuplus.com/download/release/vuplus-dvb-proxy
VUSOLO4K_DRIVER_DEPENDS = bootstrap

$(D)/vusolo4k-driver:
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	$(call TARGET_FOLLOWUP)
