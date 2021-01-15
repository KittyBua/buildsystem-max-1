#
# libplist
#
LIBPLIST_VER    = 2.1.0
LIBPLIST_DIR    = libplist-$(LIBPLIST_VER)
LIBPLIST_SOURCE = libplist-$(LIBPLIST_VER).tar.gz
LIBPLIST_SITE   = $(call github,libimobiledevice,libplist,$(LIBPLIST_VER))
LIBPLIST_DEPS   = bootstrap libxml2

LIBPLIST_CONF_OPTS = \
	--without-cython

$(D)/libplist:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		autoreconf -fi; \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
