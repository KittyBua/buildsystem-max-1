#
# libarchive
#
LIBARCHIVE_VER    = 3.4.0
LIBARCHIVE_DIR    = libarchive-$(LIBARCHIVE_VER)
LIBARCHIVE_SOURCE = libarchive-$(LIBARCHIVE_VER).tar.gz
LIBARCHIVE_SITE   = https://www.libarchive.org/downloads
LIBARCHIVE_DEPS   = bootstrap

LIBARCHIVE_CONF_OPTS = \
	--enable-static=no \
	--disable-bsdtar \
	--disable-bsdcpio \
	--without-iconv \
	--without-libiconv-prefix \
	--without-lzo2 \
	--without-nettle \
	--without-xml2 \
	--without-expat

$(D)/libarchive:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
