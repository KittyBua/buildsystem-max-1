################################################################################
#
# vuduo4k-vmlinuz-initrd 7278b1
#
################################################################################

ifeq ($(VU_MULTIBOOT),multi)
VUDUO4K_VMLINUZ_INITRD_DATE = 20190911
VUDUO4K_VMLINUZ_INITRD_SITE = https://bitbucket.org/max_10/vmlinuz-initrd-vuduo4k/downloads
else
VUDUO4K_VMLINUZ_INITRD_DATE = 20181030
VUDUO4K_VMLINUZ_INITRD_SITE = http://code.vuplus.com/download/release/kernel
endif
VUDUO4K_VMLINUZ_INITRD_VERSION = $(VUDUO4K_VMLINUZ_INITRD_DATE)
VUDUO4K_VMLINUZ_INITRD_SOURCE  = vmlinuz-initrd_vuduo4k_$(VUDUO4K_VMLINUZ_INITRD_VERSION).tar.gz

$(D)/vuduo4k-vmlinuz-initrd: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(call TARGET_FOLLOWUP)
