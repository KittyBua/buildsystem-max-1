#
# libmodplug
#
LIBMODPLUG_VER    = 0.8.8.4
LIBMODPLUG_DIR    = libmodplug-$(LIBMODPLUG_VER)
LIBMODPLUG_SOURCE = libmodplug-$(LIBMODPLUG_VER).tar.gz
LIBMODPLUG_SITE   = https://sourceforge.net/projects/modplug-xmms/files/libmodplug/$(LIBMODPLUG_VER)

$(D)/libmodplug: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
