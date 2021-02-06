#
# libdvdnav
#
LIBDVDNAV_VER    = 6.1.0
LIBDVDNAV_DIR    = libdvdnav-$(LIBDVDNAV_VER)
LIBDVDNAV_SOURCE = libdvdnav-$(LIBDVDNAV_VER).tar.bz2
LIBDVDNAV_SITE   = http://www.videolan.org/pub/videolan/libdvdnav/$(LIBDVDNAV_VER)
LIBDVDNAV_DEPS   = bootstrap libdvdread

LIBDVDNAV_AUTORECONF = YES

LIBDVDNAV_CONF_OPTS = \
	--enable-static \
	--enable-shared

$(D)/libdvdnav:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
