################################################################################
#
# libusb-compat
#
################################################################################

LIBUSB_COMPAT_VERSION = 0.1.7
LIBUSB_COMPAT_DIR = libusb-compat-$(LIBUSB_COMPAT_VERSION)
LIBUSB_COMPAT_SOURCE = libusb-compat-$(LIBUSB_COMPAT_VERSION).tar.bz2
LIBUSB_COMPAT_SITE = https://github.com/libusb/libusb-compat-0.1/releases/download/v$(LIBUSB_COMPAT_VERSION)

LIBUSB_COMPAT_DEPENDS = libusb

LIBUSB_CONF_OPTS = \
	--disable-log \
	--disable-debug-log \
	--disable-examples-build

LIBUSB_COMPAT_CONFIG_SCRIPTS = libusb-config

$(D)/libusb-compat: | bootstrap
	$(call autotools-package)
