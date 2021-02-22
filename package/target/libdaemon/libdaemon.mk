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
