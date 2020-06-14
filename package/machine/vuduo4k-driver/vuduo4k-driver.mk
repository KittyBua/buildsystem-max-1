#
# vuduo4k-driver
#
VUDUO4K_DRIVER_DATE   = 20190212
VUDUO4K_DRIVER_REV    = r0
VUDUO4K_DRIVER_VER    = 4.1.45-$(VUDUO4K_DRIVER_DATE).$(VUDUO4K_DRIVER_REV)
VUDUO4K_DRIVER_SOURCE = vuplus-dvb-proxy-vuduo4k-$(VUDUO4K_DRIVER_VER).tar.gz
VUDUO4K_DRIVER_URL    = http://archive.vuplus.com/download/build_support/vuplus

$(D)/vuduo4k-driver: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	mkdir -p $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra
	tar -xf $(DL_DIR)/$(PKG_SOURCE) -C $(TARGET_DIR)/lib/modules/$(KERNEL_VER)/extra
	make depmod
	$(TOUCH)
	make vuduo4k-platform-util
	make vuduo4k-libgles
	make vuduo4k-vmlinuz-initrd
