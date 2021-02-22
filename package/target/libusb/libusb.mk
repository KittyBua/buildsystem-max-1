#
# libusb
#
LIBUSB_VER    = 1.0.23
LIBUSB_DIR    = libusb-$(LIBUSB_VER)
LIBUSB_SOURCE = libusb-$(LIBUSB_VER).tar.bz2
LIBUSB_SITE   = https://github.com/libusb/libusb/releases/download/v$(LIBUSB_VER)
LIBUSB_DEPS   = bootstrap

LIBUSB_CONF_OPTS = \
	--enable-static \
	--disable-log \
	--disable-debug-log \
	--disable-udev \
	--disable-examples-build

$(D)/libusb:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
