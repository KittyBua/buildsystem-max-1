#
# usbutils
#
USBUTILS_VERSION = 007
USBUTILS_DIR     = usbutils-$(USBUTILS_VERSION)
USBUTILS_SOURCE  = usbutils-$(USBUTILS_VERSION).tar.xz
USBUTILS_SITE    = https://www.kernel.org/pub/linux/utils/usb/usbutils
USBUTILS_DEPENDS = bootstrap libusb

USBUTILS_AUTORECONF = YES

USBUTILS_CONF_OPTS = \
	--datadir=/usr/share/hwdata

$(D)/usbutils:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	rm -rf $(addprefix $(TARGET_DIR)/usr/bin/,lsusb.py usbhid-dump)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,pkgconfig)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/hwdata/,usb.ids.gz)
	$(TOUCH)
