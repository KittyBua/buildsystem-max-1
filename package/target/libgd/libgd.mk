#
# libgd
#
LIBGD_VERSION = 2.2.5
LIBGD_DIR     = libgd-$(LIBGD_VERSION)
LIBGD_SOURCE  = libgd-$(LIBGD_VERSION).tar.xz
LIBGD_SITE    = https://github.com/libgd/libgd/releases/download/gd-$(LIBGD_VERSION)
LIBGD_DEPENDS = bootstrap libpng libjpeg-turbo freetype

LIBGD_CONF_OPTS = \
	--bindir=$(REMOVE_bindir) \
	--without-fontconfig \
	--without-xpm \
	--without-x

$(D)/libgd:
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
