#
# vuzero4k-driver
#
VUZERO4K_DRIVER_DATE   = 20190424
VUZERO4K_DRIVER_REV    = r0
VUZERO4K_DRIVER_VER    = 4.1.20-$(VUZERO4K_DRIVER_DATE).$(VUZERO4K_DRIVER_REV)
VUZERO4K_DRIVER_SOURCE = vuplus-dvb-proxy-vuzero4k-$(VUZERO4K_DRIVER_VER).tar.gz
VUZERO4K_DRIVER_URL    = http://archive.vuplus.com/download/build_support/vuplus

$(D)/vuzero4k-driver: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	mkdir -p $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra
	tar -xf $(DL_DIR)/$(PKG_SOURCE) -C $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra
	make depmod
	$(TOUCH)
	make vuzero4k-platform-util
	make vuzero4k-libgles
	make vuzero4k-vmlinuz-initrd
