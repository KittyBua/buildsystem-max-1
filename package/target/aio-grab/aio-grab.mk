#
# aio-grab
#
AIO_GRAB_VER    = git
AIO_GRAB_DIR    = aio-grab.git
AIO_GRAB_SOURCE = aio-grab.git
AIO_GRAB_SITE   = https://github.com/oe-alliance

$(D)/aio-grab: bootstrap zlib libpng libjpeg-turbo
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(AIO_GRAB_DIR)
	$(CPDIR)/$(AIO_GRAB_DIR)
	$(CHDIR)/$(AIO_GRAB_DIR); \
		autoreconf -fi $(SILENT_OPT); \
		automake --foreign --include-deps $(SILENT_OPT); \
		$(CONFIGURE) \
			--target=$(TARGET) \
			--prefix= \
			--enable-silent-rules \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/$(AIO_GRAB_DIR)
	$(TOUCH)
