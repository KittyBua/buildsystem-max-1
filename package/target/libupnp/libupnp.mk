LIBUPNP_VER    = 1.6.25
LIBUPNP_DIR    = libupnp-$(LIBUPNP_VER)
LIBUPNP_SOURCE = libupnp-$(LIBUPNP_VER).tar.bz2
LIBUPNP_SITE   = http://sourceforge.net/projects/pupnp/files/pupnp/libUPnP%20$(LIBUPNP_VER)
LIBUPNP_DEPS   = bootstrap

LIBUPNP_CONF_OPTS = \
	--enable-shared \
	--disable-static

$(D)/libupnp:
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
