#
# libgd
#
LIBGD_VER    = 2.2.5
LIBGD_DIR    = libgd-$(LIBGD_VER)
LIBGD_SOURCE = libgd-$(LIBGD_VER).tar.xz
LIBGD_SITE   = https://github.com/libgd/libgd/releases/download/gd-$(LIBGD_VER)
LIBGD_DEPS   = bootstrap libpng libjpeg-turbo freetype

LIBGD_CONF_OPTS = \
	--bindir=$(REMOVE_bindir) \
	--without-fontconfig \
	--without-xpm \
	--without-x

$(D)/libgd:
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
