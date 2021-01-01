#
# usb-modeswitch-data
#
USB_MODESWITCH_DATA_VER    = 20191128
USB_MODESWITCH_DATA_DIR    = usb-modeswitch-data-$(USB_MODESWITCH_DATA_VER)
USB_MODESWITCH_DATA_SOURCE = usb-modeswitch-data-$(USB_MODESWITCH_DATA_VER).tar.bz2
USB_MODESWITCH_DATA_SITE   = http://www.draisberghof.de/usb_modeswitch

$(D)/usb-modeswitch-data: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
