#
# libarchive
#
LIBARCHIVE_VER    = 3.4.0
LIBARCHIVE_DIR    = libarchive-$(LIBARCHIVE_VER)
LIBARCHIVE_SOURCE = libarchive-$(LIBARCHIVE_VER).tar.gz
LIBARCHIVE_SITE   = https://www.libarchive.org/downloads

$(D)/libarchive: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--enable-static=no \
			--disable-bsdtar \
			--disable-bsdcpio \
			--without-iconv \
			--without-libiconv-prefix \
			--without-lzo2 \
			--without-nettle \
			--without-xml2 \
			--without-expat \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
