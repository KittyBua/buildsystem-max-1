################################################################################
#
# usbutils
#
################################################################################

USBUTILS_VERSION = 007
USBUTILS_DIR     = usbutils-$(USBUTILS_VERSION)
USBUTILS_SOURCE  = usbutils-$(USBUTILS_VERSION).tar.xz
USBUTILS_SITE    = https://www.kernel.org/pub/linux/utils/usb/usbutils
USBUTILS_DEPENDS = bootstrap libusb

USBUTILS_AUTORECONF = YES

USBUTILS_CONF_OPTS = \
	--datadir=/usr/share/hwdata

define USBUTILS_CLEANUP_TARGET
	rm -rf $(addprefix $(TARGET_BIN_DIR)/,lsusb.py usbhid-dump)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,pkgconfig)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/hwdata/,usb.ids.gz)
endef
USBUTILS_CLEANUP_TARGET_HOOKS += USBUTILS_CLEANUP_TARGET

$(D)/usbutils:
	$(call autotools-package)
