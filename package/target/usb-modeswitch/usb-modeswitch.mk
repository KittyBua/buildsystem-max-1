#
# usb-modeswitch
#
USB_MODESWITCH_VER    = 2.6.0
USB_MODESWITCH_DIR    = usb-modeswitch-$(USB_MODESWITCH_VER)
USB_MODESWITCH_SOURCE = usb-modeswitch-$(USB_MODESWITCH_VER).tar.bz2
USB_MODESWITCH_SITE   = http://www.draisberghof.de/usb_modeswitch

$(D)/usb-modeswitch: bootstrap libusb usb-modeswitch-data
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(BUILD_ENV) $(MAKE) DESTDIR=$(TARGET_DIR); \
		$(MAKE) install DESTDIR=$(TARGET_DIR) MANDIR=$(TARGET_DIR)$(REMOVE_mandir)
	$(PKG_REMOVE)
	$(TOUCH)
