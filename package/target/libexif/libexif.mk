#
# libexif
#
LIBEXIF_VER    = 0.6.22
LIBEXIF_DIR    = libexif-$(LIBEXIF_VER)
LIBEXIF_SOURCE = libexif-$(LIBEXIF_VER).tar.xz
LIBEXIF_SITE   = https://github.com/libexif/libexif/releases/download/libexif-$(subst .,_,$(LIBEXIF_VER))-release

$(D)/libexif: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			; \
		$(MAKE); \
		$(MAKE) install prefix=/usr DESTDIR=$(TARGET_DIR) datadir=/.remove docdir=/.remove
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
