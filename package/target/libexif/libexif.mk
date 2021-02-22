#
# libexif
#
LIBEXIF_VER    = 0.6.22
LIBEXIF_DIR    = libexif-$(LIBEXIF_VER)
LIBEXIF_SOURCE = libexif-$(LIBEXIF_VER).tar.xz
LIBEXIF_SITE   = https://github.com/libexif/libexif/releases/download/libexif-$(subst .,_,$(LIBEXIF_VER))-release
LIBEXIF_DEPS   = bootstrap

LIBEXIF_AUTORECONF = YES

$(D)/libexif:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
