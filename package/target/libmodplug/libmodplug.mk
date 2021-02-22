#
# libmodplug
#
LIBMODPLUG_VER    = 0.8.8.4
LIBMODPLUG_DIR    = libmodplug-$(LIBMODPLUG_VER)
LIBMODPLUG_SOURCE = libmodplug-$(LIBMODPLUG_VER).tar.gz
LIBMODPLUG_SITE   = https://sourceforge.net/projects/modplug-xmms/files/libmodplug/$(LIBMODPLUG_VER)
LIBMODPLUG_DEPS   = bootstrap

$(D)/libmodplug:
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
