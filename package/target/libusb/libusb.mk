################################################################################
#
# libusb
#
################################################################################

LIBUSB_VERSION = 1.0.23
LIBUSB_DIR     = libusb-$(LIBUSB_VERSION)
LIBUSB_SOURCE  = libusb-$(LIBUSB_VERSION).tar.bz2
LIBUSB_SITE    = https://github.com/libusb/libusb/releases/download/v$(LIBUSB_VERSION)
LIBUSB_DEPENDS = bootstrap

LIBUSB_CONF_OPTS = \
	--enable-static \
	--disable-log \
	--disable-debug-log \
	--disable-udev \
	--disable-examples-build

$(D)/libusb:
	$(call make-package)
