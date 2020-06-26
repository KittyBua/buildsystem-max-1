#
# vuultimo4k-vmlinuz-initrd 7445d0
#
ifeq ($(VU_MULTIBOOT), 1)
VUULTIMO4K_VMLINUZ_INITRD_DATE   = 20190911
VUULTIMO4K_VMLINUZ_INITRD_SITE   = https://bitbucket.org/max_10/vmlinuz-initrd-vuultimo4k/downloads
else
VUULTIMO4K_VMLINUZ_INITRD_DATE   = 20170209
VUULTIMO4K_VMLINUZ_INITRD_SITE   = http://archive.vuplus.com/download/kernel
endif
VUULTIMO4K_VMLINUZ_INITRD_VER    = $(VUULTIMO4K_VMLINUZ_INITRD_DATE)
VUULTIMO4K_VMLINUZ_INITRD_SOURCE = vmlinuz-initrd_vuultimo4k_$(VUULTIMO4K_VMLINUZ_INITRD_VER).tar.gz

$(D)/vuultimo4k-vmlinuz-initrd: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(TOUCH)
