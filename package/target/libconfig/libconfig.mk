#
# libconfig
#
LIBCONFIG_VER    = 1.4.10
LIBCONFIG_DIR    = libconfig-$(LIBCONFIG_VER)
LIBCONFIG_SOURCE = libconfig-$(LIBCONFIG_VER).tar.gz
LIBCONFIG_URL    = http://www.hyperrealm.com/packages

$(D)/libconfig: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--infodir=/.remove \
			--disable-static \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
