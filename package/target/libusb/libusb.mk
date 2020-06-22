#
# libusb
#
LIBUSB_VER    = 1.0.23
LIBUSB_DIR    = libusb-$(LIBUSB_VER)
LIBUSB_SOURCE = libusb-$(LIBUSB_VER).tar.bz2
LIBUSB_SITE   = https://github.com/libusb/libusb/releases/download/v$(LIBUSB_VER)

LIBUSB_PATCH  = \
	0001-libusb.patch

$(D)/libusb: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-static \
			--disable-log \
			--disable-debug-log \
			--disable-udev \
			--disable-examples-build \
			; \
		$(MAKE) ; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
