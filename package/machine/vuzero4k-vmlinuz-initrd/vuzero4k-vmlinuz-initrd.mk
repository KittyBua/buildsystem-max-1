################################################################################
#
# vuzero4k-vmlinuz-initrd 7260a0
#
################################################################################

ifeq ($(VU_MULTIBOOT),multi)
VUZERO4K_VMLINUZ_INITRD_DATE = 20190911
VUZERO4K_VMLINUZ_INITRD_SITE = https://bitbucket.org/max_10/vmlinuz-initrd-vuzero4k/downloads
else
VUZERO4K_VMLINUZ_INITRD_DATE = 20170522
VUZERO4K_VMLINUZ_INITRD_SITE = http://code.vuplus.com/download/release/kernel
endif
VUZERO4K_VMLINUZ_INITRD_VERSION = $(VUZERO4K_VMLINUZ_INITRD_DATE)
VUZERO4K_VMLINUZ_INITRD_SOURCE  = vmlinuz-initrd_vuzero4k_$(VUZERO4K_VMLINUZ_INITRD_VERSION).tar.gz
VUZERO4K_VMLINUZ_INITRD_DEPENDS = bootstrap

$(D)/vuzero4k-vmlinuz-initrd:
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(call TARGET_FOLLOWUP)
