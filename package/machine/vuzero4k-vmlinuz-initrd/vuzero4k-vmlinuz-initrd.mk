#
# vuzero4k-vmlinuz-initrd 7260a0
#
ifeq ($(VU_MULTIBOOT), 1)
VUZERO4K_VMLINUZ_INITRD_DATE   = 20190911
VUZERO4K_VMLINUZ_INITRD_SITE   = https://bitbucket.org/max_10/vmlinuz-initrd-vuzero4k/downloads
else
VUZERO4K_VMLINUZ_INITRD_DATE   = 20170522
VUZERO4K_VMLINUZ_INITRD_SITE   = http://archive.vuplus.com/download/kernel
endif
VUZERO4K_VMLINUZ_INITRD_VER    = $(VUZERO4K_VMLINUZ_INITRD_DATE)
VUZERO4K_VMLINUZ_INITRD_SOURCE = vmlinuz-initrd_vuzero4k_$(VUZERO4K_VMLINUZ_INITRD_VER).tar.gz

$(D)/vuzero4k-vmlinuz-initrd: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	tar -xf $(DL_DIR)/$(PKG_SOURCE) -C $(BUILD_DIR)
	$(TOUCH)
