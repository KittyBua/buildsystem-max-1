#
# libdaemon
#
LIBDAEMON_VER    = 0.14
LIBDAEMON_DIR    = libdaemon-$(LIBDAEMON_VER)
LIBDAEMON_SOURCE = libdaemon-$(LIBDAEMON_VER).tar.gz
LIBDAEMON_URL    = http://0pointer.de/lennart/projects/libdaemon

$(D)/libdaemon: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
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
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
