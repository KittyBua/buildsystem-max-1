#
# vuuno4k-vmlinuz-initrd 7439b0
#
ifeq ($(VU_MULTIBOOT), 1)
VUUNO4K_VMLINUZ_INITRD_DATE   = 20191010
VUUNO4K_VMLINUZ_INITRD_URL    = https://bitbucket.org/max_10/vmlinuz-initrd-vuuno4k/downloads
else
VUUNO4K_VMLINUZ_INITRD_DATE   = 20170209
VUUNO4K_VMLINUZ_INITRD_URL    = http://archive.vuplus.com/download/kernel
endif
VUUNO4K_VMLINUZ_INITRD_VER    = $(VUUNO4K_VMLINUZ_INITRD_DATE)
VUUNO4K_VMLINUZ_INITRD_SOURCE = vmlinuz-initrd_vuuno4k_$(VUUNO4K_VMLINUZ_INITRD_VER).tar.gz

$(D)/vuuno4k-vmlinuz-initrd: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	tar -xf $(DL_DIR)/$(PKG_SOURCE) -C $(BUILD_DIR)
	$(TOUCH)
