#
# usb-modeswitch-data
#
USB_MODESWITCH_DATA_VER    = 20170806
USB_MODESWITCH_DATA_DIR    = usb-modeswitch-data-$(USB_MODESWITCH_DATA_VER)
USB_MODESWITCH_DATA_SOURCE = usb-modeswitch-data-$(USB_MODESWITCH_DATA_VER).tar.bz2
USB_MODESWITCH_DATA_SITE   = http://www.draisberghof.de/usb_modeswitch

USB_MODESWITCH_DATA_PATCH  = \
	0001-usb-modeswitch-data.patch

$(D)/usb-modeswitch-data: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
