################################################################################
#
# vuuno4k-driver
#
################################################################################

VUUNO4K_DRIVER_DATE    = 20190104
VUUNO4K_DRIVER_REV     = r0
VUUNO4K_DRIVER_VERSION = 3.14.28-$(VUUNO4K_DRIVER_DATE).$(VUUNO4K_DRIVER_REV)
VUUNO4K_DRIVER_SOURCE  = vuplus-dvb-proxy-vuuno4k-$(VUUNO4K_DRIVER_VERSION).tar.gz
VUUNO4K_DRIVER_SITE    = http://code.vuplus.com/download/release/vuplus-dvb-proxy
VUUNO4K_DRIVER_DEPENDS = bootstrap

$(D)/vuuno4k-driver:
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	$(call TARGET_FOLLOWUP)
