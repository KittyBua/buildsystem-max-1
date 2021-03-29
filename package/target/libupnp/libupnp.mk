LIBUPNP_VERSION = 1.6.25
LIBUPNP_DIR     = libupnp-$(LIBUPNP_VERSION)
LIBUPNP_SOURCE  = libupnp-$(LIBUPNP_VERSION).tar.bz2
LIBUPNP_SITE    = http://sourceforge.net/projects/pupnp/files/pupnp/libUPnP%20$(LIBUPNP_VERSION)
LIBUPNP_DEPENDS = bootstrap

LIBUPNP_CONF_OPTS = \
	--enable-shared \
	--disable-static

libupnp:
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
