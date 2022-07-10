################################################################################
#
# libdaemon
#
################################################################################

LIBDAEMON_VERSION = 0.14
LIBDAEMON_DIR = libdaemon-$(LIBDAEMON_VERSION)
LIBDAEMON_SOURCE = libdaemon-$(LIBDAEMON_VERSION).tar.gz
LIBDAEMON_SITE = http://0pointer.de/lennart/projects/libdaemon

LIBDAEMON_CONF_OPTS = \
	ac_cv_func_setpgrp_void=yes \
	--docdir=$(REMOVE_docdir) \
	--enable-shared \
	--enable-static \
	--disable-lynx \
	--disable-examples

$(D)/libdaemon: | bootstrap
	$(call autotools-package)
