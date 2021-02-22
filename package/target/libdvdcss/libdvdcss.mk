#
# libdvdcss
#
LIBDVDCSS_VER    = 1.4.2
LIBDVDCSS_DIR    = libdvdcss-$(LIBDVDCSS_VER)
LIBDVDCSS_SOURCE = libdvdcss-$(LIBDVDCSS_VER).tar.bz2
LIBDVDCSS_SITE   = https://download.videolan.org/pub/libdvdcss/$(LIBDVDCSS_VER)
LIBDVDCSS_DEPS   = bootstrap

LIBDVDCSS_CONF_OPTS = \
	--docdir=$(REMOVE_docdir)

$(D)/libdvdcss:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
