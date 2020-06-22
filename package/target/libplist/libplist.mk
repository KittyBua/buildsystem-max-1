#
# libplist
#
LIBPLIST_VER    = 2.0.0
LIBPLIST_DIR    = libplist-$(LIBPLIST_VER)
LIBPLIST_SOURCE = libplist-$(LIBPLIST_VER).tar.bz2
LIBPLIST_SITE   = http://www.libimobiledevice.org/downloads

$(D)/libplist: bootstrap libxml2
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--without-cython \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
