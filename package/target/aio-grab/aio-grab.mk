#
# aio-grab
#
AIO_GRAB_VER    = git
AIO_GRAB_DIR    = aio-grab.git
AIO_GRAB_SOURCE = aio-grab.git
AIO_GRAB_SITE   = https://github.com/oe-alliance
AIO_GRAB_DEPS   = bootstrap zlib libpng libjpeg-turbo

AIO_GRAB_AUTORECONF = YES

AIO_GRAB_CONF_OPTS = \
	--bindir=$(base_bindir) \
	--enable-silent-rules

$(D)/aio-grab:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
