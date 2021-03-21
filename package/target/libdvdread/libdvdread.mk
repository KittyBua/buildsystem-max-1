#
# libdvdread
#
LIBDVDREAD_VERSION = 6.1.1
LIBDVDREAD_DIR     = libdvdread-$(LIBDVDREAD_VERSION)
LIBDVDREAD_SOURCE  = libdvdread-$(LIBDVDREAD_VERSION).tar.bz2
LIBDVDREAD_SITE    = http://www.videolan.org/pub/videolan/libdvdread/$(LIBDVDREAD_VERSION)
LIBDVDREAD_DEPENDS = bootstrap libdvdcss

LIBDVDREAD_CONF_ENV = CFLAGS="$(TARGET_CFLAGS) -std=gnu99"

LIBDVDREAD_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--enable-static \
	--enable-shared \
	--with-libdvdcss

$(D)/libdvdread:
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
