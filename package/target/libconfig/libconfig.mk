#
# libconfig
#
LIBCONFIG_VER    = 1.4.10
LIBCONFIG_DIR    = libconfig-$(LIBCONFIG_VER)
LIBCONFIG_SOURCE = libconfig-$(LIBCONFIG_VER).tar.gz
LIBCONFIG_SITE   = http://www.hyperrealm.com/packages

$(D)/libconfig: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--infodir=/.remove \
			--disable-static \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
