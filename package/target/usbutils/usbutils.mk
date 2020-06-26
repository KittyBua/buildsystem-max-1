#
# usbutils
#
USBUTILS_VER    = 007
USBUTILS_DIR    = usbutils-$(USBUTILS_VER)
USBUTILS_SOURCE = usbutils-$(USBUTILS_VER).tar.xz
USBUTILS_SITE   = https://www.kernel.org/pub/linux/utils/usb/usbutils

USBUTILS_PATCH  = \
	0001-avoid-dependency-on-bash.patch \
	0002-fix-null-pointer-crash.patch \
	0003-fix-build.patch \
	0004-iconv.patch

$(D)/usbutils: libusb
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--target=$(TARGET) \
			--prefix=/usr \
			--mandir=/.remove \
			--datadir=/usr/share/hwdata \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -rf $(addprefix $(TARGET_DIR)/usr/bin/,lsusb.py usbhid-dump)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,pkgconfig)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/hwdata/,usb.ids.gz)
	$(PKG_REMOVE)
	$(TOUCH)
