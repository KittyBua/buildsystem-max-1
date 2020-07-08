#
# libdaemon
#
LIBDAEMON_VER    = 0.14
LIBDAEMON_DIR    = libdaemon-$(LIBDAEMON_VER)
LIBDAEMON_SOURCE = libdaemon-$(LIBDAEMON_VER).tar.gz
LIBDAEMON_SITE   = http://0pointer.de/lennart/projects/libdaemon

$(D)/libdaemon: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			ac_cv_func_setpgrp_void=yes \
			--prefix=/usr \
			--docdir=/.remove \
			--disable-static \
			--disable-lynx \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
