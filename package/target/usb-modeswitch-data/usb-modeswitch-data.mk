#
# usb-modeswitch-data
#
USB_MODESWITCH_DATA_VER    = 20191128
USB_MODESWITCH_DATA_DIR    = usb-modeswitch-data-$(USB_MODESWITCH_DATA_VER)
USB_MODESWITCH_DATA_SOURCE = usb-modeswitch-data-$(USB_MODESWITCH_DATA_VER).tar.bz2
USB_MODESWITCH_DATA_SITE   = http://www.draisberghof.de/usb_modeswitch
USB_MODESWITCH_DATA_DEPS   = bootstrap

$(D)/usb-modeswitch-data:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
