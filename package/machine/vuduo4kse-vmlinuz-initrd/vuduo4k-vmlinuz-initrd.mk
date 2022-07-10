################################################################################
#
# vuduo4kse-vmlinuz-initrd 7278b1
#
################################################################################

ifeq ($(VU_MULTIBOOT),multi)
VUDUO4KSE_VMLINUZ_INITRD_DATE = 20201010
VUDUO4KSE_VMLINUZ_INITRD_SITE = https://bitbucket.org/max_10/vmlinuz-initrd-vuduo4kse/downloads
else
VUDUO4KSE_VMLINUZ_INITRD_DATE = 20200326
VUDUO4KSE_VMLINUZ_INITRD_SITE = http://code.vuplus.com/download/release/kernel
endif
VUDUO4KSE_VMLINUZ_INITRD_VERSION = $(VUDUO4KSE_VMLINUZ_INITRD_DATE)
VUDUO4KSE_VMLINUZ_INITRD_SOURCE  = vmlinuz-initrd_vuduo4kse_$(VUDUO4KSE_VMLINUZ_INITRD_VERSION).tar.gz

$(D)/vuduo4kse-vmlinuz-initrd: | bootstrap
	$(call STARTUP)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(call TARGET_FOLLOWUP)
