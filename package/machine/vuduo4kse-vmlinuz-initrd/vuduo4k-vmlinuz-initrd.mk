#
# vuduo4kse-vmlinuz-initrd 7278b1
#
ifeq ($(VU_MULTIBOOT),1)
VUDUO4KSE_VMLINUZ_INITRD_DATE   = 20201010
VUDUO4KSE_VMLINUZ_INITRD_SITE   = https://bitbucket.org/max_10/vmlinuz-initrd-vuduo4kse/downloads
else
VUDUO4KSE_VMLINUZ_INITRD_DATE   = 20200326
VUDUO4KSE_VMLINUZ_INITRD_SITE   = http://archive.vuplus.com/download/kernel
endif
VUDUO4KSE_VMLINUZ_INITRD_VER    = $(VUDUO4KSE_VMLINUZ_INITRD_DATE)
VUDUO4KSE_VMLINUZ_INITRD_SOURCE = vmlinuz-initrd_vuduo4kse_$(VUDUO4KSE_VMLINUZ_INITRD_VER).tar.gz
VUDUO4KSE_VMLINUZ_INITRD_DEPS   = bootstrap

$(D)/vuduo4kse-vmlinuz-initrd:
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(TOUCH)
