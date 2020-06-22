#
# aio-grab
#
AIO_GRAB_VER    = git
AIO_GRAB_DIR    = aio-grab.git
AIO_GRAB_SOURCE = aio-grab.git
AIO_GRAB_SITE   = https://github.com/oe-alliance

$(D)/aio-grab: bootstrap zlib libpng libjpeg-turbo
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_CPDIR)
	$(PKG_CHDIR); \
		autoreconf -fi $(SILENT_OPT); \
		automake --foreign --include-deps $(SILENT_OPT); \
		$(CONFIGURE) \
			--target=$(TARGET) \
			--prefix= \
			--enable-silent-rules \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
