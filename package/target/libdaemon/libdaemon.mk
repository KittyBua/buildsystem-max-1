#
# libdaemon
#
LIBDAEMON_VER    = 0.14
LIBDAEMON_DIR    = libdaemon-$(LIBDAEMON_VER)
LIBDAEMON_SOURCE = libdaemon-$(LIBDAEMON_VER).tar.gz
LIBDAEMON_SITE   = http://0pointer.de/lennart/projects/libdaemon
LIBDAEMON_DEPS   = bootstrap

LIBDAEMON_CONF_OPTS = \
	ac_cv_func_setpgrp_void=yes \
	--docdir=$(REMOVE_docdir) \
	--enable-shared \
	--enable-static \
	--disable-lynx \
	--disable-examples

$(D)/libdaemon:
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
