#
# vuuno4k-driver
#
VUUNO4K_DRIVER_DATE   = 20190104
VUUNO4K_DRIVER_REV    = r0
VUUNO4K_DRIVER_VER    = 3.14.28-$(VUUNO4K_DRIVER_DATE).$(VUUNO4K_DRIVER_REV)
VUUNO4K_DRIVER_SOURCE = vuplus-dvb-proxy-vuuno4k-$(VUUNO4K_DRIVER_VER).tar.gz
VUUNO4K_DRIVER_SITE   = http://archive.vuplus.com/download/build_support/vuplus

$(D)/vuuno4k-driver: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	mkdir -p $(TARGET_MODULES_DIR)/extra
	$(call PKG_UNPACK,$(TARGET_MODULES_DIR)/extra)
	$(TOUCH)
