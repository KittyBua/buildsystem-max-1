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
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
