#
# libdvdread
#
LIBDVDREAD_VER    = 4.9.9
LIBDVDREAD_DIR    = libdvdread-$(LIBDVDREAD_VER)
LIBDVDREAD_SOURCE = libdvdread-$(LIBDVDREAD_VER).tar.xz
LIBDVDREAD_SITE   = http://dvdnav.mplayerhq.hu/releases
LIBDVDREAD_DEPS   = bootstrap

LIBDVDREAD_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--enable-static \
	--enable-shared

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
