#
# vuuno4kse-vmlinuz-initrd 7439b0
#
ifeq ($(VU_MULTIBOOT),1)
VUUNO4KSE_VMLINUZ_INITRD_DATE = 20191010
VUUNO4KSE_VMLINUZ_INITRD_SITE = https://bitbucket.org/max_10/vmlinuz-initrd-vuuno4kse/downloads
else
VUUNO4KSE_VMLINUZ_INITRD_DATE = 20170627
VUUNO4KSE_VMLINUZ_INITRD_SITE = http://code.vuplus.com/download/release/kernel
endif
VUUNO4KSE_VMLINUZ_INITRD_VERSION = $(VUUNO4KSE_VMLINUZ_INITRD_DATE)
VUUNO4KSE_VMLINUZ_INITRD_SOURCE  = vmlinuz-initrd_vuuno4kse_$(VUUNO4KSE_VMLINUZ_INITRD_VERSION).tar.gz
VUUNO4KSE_VMLINUZ_INITRD_DEPENDS = bootstrap

vuuno4kse-vmlinuz-initrd:
	$(START_BUILD)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(TOUCH)
