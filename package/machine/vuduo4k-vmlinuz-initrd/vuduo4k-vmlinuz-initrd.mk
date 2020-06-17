#
# vuduo4k-vmlinuz-initrd 7278b1
#
ifeq ($(VU_MULTIBOOT), 1)
VUDUO4K_VMLINUZ_INITRD_DATE   = 20190911
VUDUO4K_VMLINUZ_INITRD_SITE   = https://bitbucket.org/max_10/vmlinuz-initrd-vuduo4k/downloads
else
VUDUO4K_VMLINUZ_INITRD_DATE   = 20181030
VUDUO4K_VMLINUZ_INITRD_SITE   = http://archive.vuplus.com/download/kernel
endif
VUDUO4K_VMLINUZ_INITRD_VER    = $(VUDUO4K_VMLINUZ_INITRD_DATE)
VUDUO4K_VMLINUZ_INITRD_SOURCE = vmlinuz-initrd_vuduo4k_$(VUDUO4K_VMLINUZ_INITRD_VER).tar.gz

$(D)/vuduo4k-vmlinuz-initrd: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	tar -xf $(DL_DIR)/$(PKG_SOURCE) -C $(BUILD_DIR)
	$(TOUCH)
