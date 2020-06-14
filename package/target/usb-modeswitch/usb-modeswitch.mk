#
# usb-modeswitch
#
USB_MODESWITCH_VER    = 2.5.2
USB_MODESWITCH_DIR    = usb-modeswitch-$(USB_MODESWITCH_VER)
USB_MODESWITCH_SOURCE = usb-modeswitch-$(USB_MODESWITCH_VER).tar.bz2
USB_MODESWITCH_URL    = http://www.draisberghof.de/usb_modeswitch

USB_MODESWITCH_PATCH  = \
	0001-usb-modeswitch.patch

$(D)/usb-modeswitch: bootstrap libusb usb-modeswitch-data
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		sed -i -e "s/= gcc/= $(TARGET_CC)/" -e "s/-l usb/-lusb -lusb-1.0 -lpthread -lrt/" -e "s/install -D -s/install -D --strip-program=$(TARGET_STRIP) -s/" Makefile; \
		sed -i -e "s/@CC@/$(TARGET_CC)/g" jim/Makefile.in; \
		$(BUILD_ENV) $(MAKE) DESTDIR=$(TARGET_DIR); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
