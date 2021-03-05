#
# libusb-compat
#
LIBUSB_COMPAT_VER    = 0.1.7
LIBUSB_COMPAT_DIR    = libusb-compat-$(LIBUSB_COMPAT_VER)
LIBUSB_COMPAT_SOURCE = libusb-compat-$(LIBUSB_COMPAT_VER).tar.bz2
LIBUSB_COMPAT_SITE   = https://github.com/libusb/libusb-compat-0.1/releases/download/v$(LIBUSB_COMPAT_VER)
LIBUSB_COMPAT_DEPS   = bootstrap libusb

LIBUSB_CONF_OPTS = \
	--disable-log \
	--disable-debug-log \
	--disable-examples-build

LIBUSB_COMPAT_CONFIG_SCRIPTS = libusb-config

$(D)/libusb-compat:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_CONFIG_SCRIPTS)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
