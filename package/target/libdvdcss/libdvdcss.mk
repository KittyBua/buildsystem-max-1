#
# libdvdcss
#
LIBDVDCSS_VERSION = 1.4.2
LIBDVDCSS_DIR     = libdvdcss-$(LIBDVDCSS_VERSION)
LIBDVDCSS_SOURCE  = libdvdcss-$(LIBDVDCSS_VERSION).tar.bz2
LIBDVDCSS_SITE    = https://download.videolan.org/pub/libdvdcss/$(LIBDVDCSS_VERSION)
LIBDVDCSS_DEPENDS = bootstrap

LIBDVDCSS_CONF_OPTS = \
	--docdir=$(REMOVE_docdir)

libdvdcss:
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
