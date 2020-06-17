#
# vuuno4kse-driver
#
VUUNO4KSE_DRIVER_DATE   = 20190104
VUUNO4KSE_DRIVER_REV    = r0
VUUNO4KSE_DRIVER_VER    = 4.1.20-$(VUUNO4KSE_DRIVER_DATE).$(VUUNO4KSE_DRIVER_REV)
VUUNO4KSE_DRIVER_SOURCE = vuplus-dvb-proxy-vuuno4kse-$(VUUNO4KSE_DRIVER_VER).tar.gz
VUUNO4KSE_DRIVER_SITE   = http://archive.vuplus.com/download/build_support/vuplus

$(D)/vuuno4kse-driver: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	mkdir -p $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra
	tar -xf $(DL_DIR)/$(PKG_SOURCE) -C $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra
	make depmod
	$(TOUCH)
	make vuuno4kse-platform-util
	make vuuno4kse-libgles
	make vuuno4kse-vmlinuz-initrd
