################################################################################
#
# usb-modeswitch-data
#
################################################################################

USB_MODESWITCH_DATA_VERSION = 20191128
USB_MODESWITCH_DATA_DIR = usb-modeswitch-data-$(USB_MODESWITCH_DATA_VERSION)
USB_MODESWITCH_DATA_SOURCE = usb-modeswitch-data-$(USB_MODESWITCH_DATA_VERSION).tar.bz2
USB_MODESWITCH_DATA_SITE = http://www.draisberghof.de/usb_modeswitch

USB_MODESWITCH_DATA_DEPENDS = bootstrap

$(D)/usb-modeswitch-data:
	$(call generic-package)
