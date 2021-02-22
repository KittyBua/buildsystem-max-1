#
# usb-modeswitch
#
USB_MODESWITCH_VER    = 2.6.0
USB_MODESWITCH_DIR    = usb-modeswitch-$(USB_MODESWITCH_VER)
USB_MODESWITCH_SOURCE = usb-modeswitch-$(USB_MODESWITCH_VER).tar.bz2
USB_MODESWITCH_SITE   = http://www.draisberghof.de/usb_modeswitch
USB_MODESWITCH_DEPS   = bootstrap libusb usb-modeswitch-data

$(D)/usb-modeswitch:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(TARGET_CONFIGURE_ENV) $(MAKE) DESTDIR=$(TARGET_DIR); \
		$(MAKE) install DESTDIR=$(TARGET_DIR) MANDIR=$(TARGET_DIR)$(REMOVE_mandir)
	$(REMOVE)
	$(TOUCH)
