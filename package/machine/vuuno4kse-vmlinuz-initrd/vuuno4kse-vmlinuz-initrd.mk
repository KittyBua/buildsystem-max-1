#
# vuuno4kse-vmlinuz-initrd 7439b0
#
ifeq ($(VU_MULTIBOOT), 1)
VUUNO4KSE_VMLINUZ_INITRD_DATE   = 20191010
VUUNO4KSE_VMLINUZ_INITRD_SITE   = https://bitbucket.org/max_10/vmlinuz-initrd-vuuno4kse/downloads
else
VUUNO4KSE_VMLINUZ_INITRD_DATE   = 20170627
VUUNO4KSE_VMLINUZ_INITRD_SITE   = http://archive.vuplus.com/download/kernel
endif
VUUNO4KSE_VMLINUZ_INITRD_VER    = $(VUUNO4KSE_VMLINUZ_INITRD_DATE)
VUUNO4KSE_VMLINUZ_INITRD_SOURCE = vmlinuz-initrd_vuuno4kse_$(VUUNO4KSE_VMLINUZ_INITRD_VER).tar.gz

$(D)/vuuno4kse-vmlinuz-initrd: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	tar -xf $(DL_DIR)/$(PKG_SOURCE) -C $(BUILD_DIR)
	$(TOUCH)
