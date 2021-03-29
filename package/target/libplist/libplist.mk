#
# libplist
#
LIBPLIST_VERSION = 2.1.0
LIBPLIST_DIR     = libplist-$(LIBPLIST_VERSION)
LIBPLIST_SOURCE  = libplist-$(LIBPLIST_VERSION).tar.gz
LIBPLIST_SITE    = $(call github,libimobiledevice,libplist,$(LIBPLIST_VERSION))
LIBPLIST_DEPENDS = bootstrap libxml2

LIBPLIST_AUTORECONF = YES

LIBPLIST_CONF_OPTS = \
	--without-cython

libplist:
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
