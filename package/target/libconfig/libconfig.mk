#
# libconfig
#
LIBCONFIG_VER    = 1.4.10
LIBCONFIG_DIR    = libconfig-$(LIBCONFIG_VER)
LIBCONFIG_SOURCE = libconfig-$(LIBCONFIG_VER).tar.gz
LIBCONFIG_SITE   = http://www.hyperrealm.com/packages
LIBCONFIG_DEPS   = bootstrap

LIBCONFIG_CONF_OPTS = \
	--disable-static

$(D)/libconfig:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
