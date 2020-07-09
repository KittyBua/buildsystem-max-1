#
# libplist
#
LIBPLIST_VER    = 2.1.0
LIBPLIST_DIR    = libplist-$(LIBPLIST_VER)
LIBPLIST_SOURCE = libplist-$(LIBPLIST_VER).tar.gz
LIBPLIST_SITE   = $(call github,libimobiledevice,libplist,$(LIBPLIST_VER))

$(D)/libplist: bootstrap libxml2
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
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
