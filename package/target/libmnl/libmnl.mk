#
# libmnl
#
LIBMNL_VERSION = 1.0.4
LIBMNL_DIR     = libmnl-$(LIBMNL_VERSION)
LIBMNL_SOURCE  = libmnl-$(LIBMNL_VERSION).tar.bz2
LIBMNL_SITE    = http://netfilter.org/projects/libmnl/files
LIBMNL_DEPENDS = bootstrap

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
