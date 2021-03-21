#
# libdvdnav
#
LIBDVDNAV_VERSION = 6.1.0
LIBDVDNAV_DIR     = libdvdnav-$(LIBDVDNAV_VERSION)
LIBDVDNAV_SOURCE  = libdvdnav-$(LIBDVDNAV_VERSION).tar.bz2
LIBDVDNAV_SITE    = http://www.videolan.org/pub/videolan/libdvdnav/$(LIBDVDNAV_VERSION)
LIBDVDNAV_DEPENDS = bootstrap libdvdread

LIBDVDNAV_AUTORECONF = YES

LIBDVDNAV_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--enable-static \
	--enable-shared

$(D)/libdvdnav:
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
