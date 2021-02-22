#
# vuuno4kse-driver
#
VUUNO4KSE_DRIVER_DATE   = 20190424
VUUNO4KSE_DRIVER_REV    = r0
VUUNO4KSE_DRIVER_VER    = 4.1.20-$(VUUNO4KSE_DRIVER_DATE).$(VUUNO4KSE_DRIVER_REV)
VUUNO4KSE_DRIVER_SOURCE = vuplus-dvb-proxy-vuuno4kse-$(VUUNO4KSE_DRIVER_VER).tar.gz
VUUNO4KSE_DRIVER_SITE   = http://code.vuplus.com/download/release/vuplus-dvb-proxy
VUUNO4KSE_DRIVER_DEPS   = bootstrap

$(D)/vuuno4kse-driver:
	$(START_BUILD)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call EXTRACT,$(TARGET_MODULES_DIR)/extra)
	$(TOUCH)
