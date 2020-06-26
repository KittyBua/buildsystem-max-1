#
# vusolo4k-vmlinuz-initrd 7366c0
#
ifeq ($(VU_MULTIBOOT), 1)
VUSOLO4K_VMLINUZ_INITRD_DATE   = 20190911
VUSOLO4K_VMLINUZ_INITRD_SITE   = https://bitbucket.org/max_10/vmlinuz-initrd-vusolo4k/downloads
else
VUSOLO4K_VMLINUZ_INITRD_DATE   = 20170209
VUSOLO4K_VMLINUZ_INITRD_SITE   = http://archive.vuplus.com/download/kernel
endif
VUSOLO4K_VMLINUZ_INITRD_VER    = $(VUSOLO4K_VMLINUZ_INITRD_DATE)
VUSOLO4K_VMLINUZ_INITRD_SOURCE = vmlinuz-initrd_vusolo4k_$(VUSOLO4K_VMLINUZ_INITRD_VER).tar.gz

$(D)/vusolo4k-vmlinuz-initrd: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(TOUCH)
