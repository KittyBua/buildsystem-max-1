#
# libdvdcss
#
LIBDVDCSS_VER    = 1.2.13
LIBDVDCSS_DIR    = libdvdcss-$(LIBDVDCSS_VER)
LIBDVDCSS_SOURCE = libdvdcss-$(LIBDVDCSS_VER).tar.bz2
LIBDVDCSS_SITE   = https://download.videolan.org/pub/libdvdcss/$(LIBDVDCSS_VER)

LIBDVDCSS_CONF_OPTS = \
	--docdir=$(REMOVE_docdir)

$(D)/libdvdcss: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
