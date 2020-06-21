#
# libusb-compat
#
LIBUSB_COMPAT_VER    = 0.1.7
LIBUSB_COMPAT_DIR    = libusb-compat-$(LIBUSB_COMPAT_VER)
LIBUSB_COMPAT_SOURCE = libusb-compat-$(LIBUSB_COMPAT_VER).tar.bz2
LIBUSB_COMPAT_SITE   = https://github.com/libusb/libusb-compat-0.1/releases/download/v$(LIBUSB_COMPAT_VER)

LIBUSB_COMPAT_PATCH  = \
	0001-fix-a-build-issue-on-linux.patch \
	0002-fix-deprecated-libusb_set_debug.patch

$(D)/libusb-compat: bootstrap libusb
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--disable-log \
			--disable-debug-log \
			--disable-examples-build \
			; \
		$(MAKE) ; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/bin/libusb-config $(HOST_DIR)/bin
	$(REWRITE_CONFIG) $(HOST_DIR)/bin/libusb-config
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
