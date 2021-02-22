#
# vuzero4k-vmlinuz-initrd 7260a0
#
ifeq ($(VU_MULTIBOOT),1)
VUZERO4K_VMLINUZ_INITRD_DATE   = 20190911
VUZERO4K_VMLINUZ_INITRD_SITE   = https://bitbucket.org/max_10/vmlinuz-initrd-vuzero4k/downloads
else
VUZERO4K_VMLINUZ_INITRD_DATE   = 20170522
VUZERO4K_VMLINUZ_INITRD_SITE   = http://archive.vuplus.com/download/kernel
endif
VUZERO4K_VMLINUZ_INITRD_VER    = $(VUZERO4K_VMLINUZ_INITRD_DATE)
VUZERO4K_VMLINUZ_INITRD_SOURCE = vmlinuz-initrd_vuzero4k_$(VUZERO4K_VMLINUZ_INITRD_VER).tar.gz
VUZERO4K_VMLINUZ_INITRD_DEPS   = bootstrap

$(D)/vuzero4k-vmlinuz-initrd:
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(TOUCH)
