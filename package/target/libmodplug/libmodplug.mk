#
# libmodplug
#
LIBMODPLUG_VER    = 0.8.8.4
LIBMODPLUG_DIR    = libmodplug-$(LIBMODPLUG_VER)
LIBMODPLUG_SOURCE = libmodplug-$(LIBMODPLUG_VER).tar.gz
LIBMODPLUG_SITE   = https://sourceforge.net/projects/modplug-xmms/files/libmodplug/$(LIBMODPLUG_VER)

$(D)/libmodplug: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
