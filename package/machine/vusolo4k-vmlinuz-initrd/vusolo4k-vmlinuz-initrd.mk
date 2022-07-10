################################################################################
#
# vusolo4k-vmlinuz-initrd 7366c0
#
################################################################################

ifeq ($(VU_MULTIBOOT),multi)
VUSOLO4K_VMLINUZ_INITRD_DATE = 20190911
VUSOLO4K_VMLINUZ_INITRD_SITE = https://bitbucket.org/max_10/vmlinuz-initrd-vusolo4k/downloads
else
VUSOLO4K_VMLINUZ_INITRD_DATE = 20170209
VUSOLO4K_VMLINUZ_INITRD_SITE = http://code.vuplus.com/download/release/kernel
endif
VUSOLO4K_VMLINUZ_INITRD_VERSION = $(VUSOLO4K_VMLINUZ_INITRD_DATE)
VUSOLO4K_VMLINUZ_INITRD_SOURCE  = vmlinuz-initrd_vusolo4k_$(VUSOLO4K_VMLINUZ_INITRD_VERSION).tar.gz

$(D)/vusolo4k-vmlinuz-initrd: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(call TARGET_FOLLOWUP)
