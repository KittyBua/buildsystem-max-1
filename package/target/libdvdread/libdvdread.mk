#
# libdvdread
#
LIBDVDREAD_VER    = 6.1.1
LIBDVDREAD_DIR    = libdvdread-$(LIBDVDREAD_VER)
LIBDVDREAD_SOURCE = libdvdread-$(LIBDVDREAD_VER).tar.bz2
LIBDVDREAD_SITE   = http://www.videolan.org/pub/videolan/libdvdread/$(LIBDVDREAD_VER)
LIBDVDREAD_DEPS   = bootstrap libdvdcss

LIBDVDREAD_CONF_ENV = CFLAGS="$(TARGET_CFLAGS) -std=gnu99"

LIBDVDREAD_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--enable-static \
	--enable-shared \
	--with-libdvdcss

$(D)/libdvdread:
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
