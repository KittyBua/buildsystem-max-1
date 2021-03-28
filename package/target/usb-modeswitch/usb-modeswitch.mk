#
# usb-modeswitch
#
USB_MODESWITCH_VERSION = 2.6.0
USB_MODESWITCH_DIR     = usb-modeswitch-$(USB_MODESWITCH_VERSION)
USB_MODESWITCH_SOURCE  = usb-modeswitch-$(USB_MODESWITCH_VERSION).tar.bz2
USB_MODESWITCH_SITE    = http://www.draisberghof.de/usb_modeswitch
USB_MODESWITCH_DEPENDS = bootstrap libusb usb-modeswitch-data

$(D)/usb-modeswitch:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(TARGET_CONFIGURE_OPTS) $(MAKE) DESTDIR=$(TARGET_DIR); \
		$(MAKE) install DESTDIR=$(TARGET_DIR) MANDIR=$(TARGET_DIR)$(REMOVE_mandir)
	$(REMOVE)
	$(TOUCH)
