#
# libmnl
#
LIBMNL_VER    = 1.0.4
LIBMNL_DIR    = libmnl-$(LIBMNL_VER)
LIBMNL_SOURCE = libmnl-$(LIBMNL_VER).tar.bz2
LIBMNL_URL    = http://netfilter.org/projects/libmnl/files

$(D)/libmnl: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(CONFIGURE) \
			--prefix=/usr \
		; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
