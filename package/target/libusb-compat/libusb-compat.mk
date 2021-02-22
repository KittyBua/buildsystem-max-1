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

$(D)/libusb-compat:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/bin/libusb-config $(HOST_DIR)/bin
	$(REWRITE_CONFIG) $(HOST_DIR)/bin/libusb-config
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
