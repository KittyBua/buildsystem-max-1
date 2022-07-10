################################################################################
#
# vuultimo4k-vmlinuz-initrd 7445d0
#
################################################################################

ifeq ($(VU_MULTIBOOT),multi)
VUULTIMO4K_VMLINUZ_INITRD_DATE = 20190911
VUULTIMO4K_VMLINUZ_INITRD_SITE = https://bitbucket.org/max_10/vmlinuz-initrd-vuultimo4k/downloads
else
VUULTIMO4K_VMLINUZ_INITRD_DATE = 20170209
VUULTIMO4K_VMLINUZ_INITRD_SITE = http://code.vuplus.com/download/release/kernel
endif
VUULTIMO4K_VMLINUZ_INITRD_VERSION = $(VUULTIMO4K_VMLINUZ_INITRD_DATE)
VUULTIMO4K_VMLINUZ_INITRD_SOURCE  = vmlinuz-initrd_vuultimo4k_$(VUULTIMO4K_VMLINUZ_INITRD_VERSION).tar.gz

$(D)/vuultimo4k-vmlinuz-initrd: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(call TARGET_FOLLOWUP)
