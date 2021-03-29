#
# libexif
#
LIBEXIF_VERSION = 0.6.22
LIBEXIF_DIR     = libexif-$(LIBEXIF_VERSION)
LIBEXIF_SOURCE  = libexif-$(LIBEXIF_VERSION).tar.xz
LIBEXIF_SITE    = https://github.com/libexif/libexif/releases/download/libexif-$(subst .,_,$(LIBEXIF_VERSION))-release
LIBEXIF_DEPENDS = bootstrap

LIBEXIF_AUTORECONF = YES

libexif:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
