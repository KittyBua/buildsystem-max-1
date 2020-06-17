#
# libarchive
#
LIBARCHIVE_VER    = 3.4.0
LIBARCHIVE_DIR    = libarchive-$(LIBARCHIVE_VER)
LIBARCHIVE_SOURCE = libarchive-$(LIBARCHIVE_VER).tar.gz
LIBARCHIVE_SITE   = https://www.libarchive.org/downloads

$(D)/libarchive: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
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
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
