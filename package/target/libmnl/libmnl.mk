#
# libmnl
#
LIBMNL_VER    = 1.0.4
LIBMNL_DIR    = libmnl-$(LIBMNL_VER)
LIBMNL_SOURCE = libmnl-$(LIBMNL_VER).tar.bz2
LIBMNL_SITE   = http://netfilter.org/projects/libmnl/files
LIBMNL_DEPS   = bootstrap

$(D)/libmnl:
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
