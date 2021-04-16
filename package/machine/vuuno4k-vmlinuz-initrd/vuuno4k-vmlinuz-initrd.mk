#
# vuuno4k-vmlinuz-initrd 7439b0
#
ifeq ($(VU_MULTIBOOT),multi)
VUUNO4K_VMLINUZ_INITRD_DATE = 20191010
VUUNO4K_VMLINUZ_INITRD_SITE = https://bitbucket.org/max_10/vmlinuz-initrd-vuuno4k/downloads
else
VUUNO4K_VMLINUZ_INITRD_DATE = 20170209
VUUNO4K_VMLINUZ_INITRD_SITE = http://code.vuplus.com/download/release/kernel
endif
VUUNO4K_VMLINUZ_INITRD_VERSION = $(VUUNO4K_VMLINUZ_INITRD_DATE)
VUUNO4K_VMLINUZ_INITRD_SOURCE  = vmlinuz-initrd_vuuno4k_$(VUUNO4K_VMLINUZ_INITRD_VERSION).tar.gz
VUUNO4K_VMLINUZ_INITRD_DEPENDS = bootstrap

$(D)/vuuno4k-vmlinuz-initrd:
	$(START_BUILD)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(TOUCH)
