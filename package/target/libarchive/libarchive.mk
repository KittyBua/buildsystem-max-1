#
# libarchive
#
LIBARCHIVE_VERSION = 3.4.0
LIBARCHIVE_DIR     = libarchive-$(LIBARCHIVE_VERSION)
LIBARCHIVE_SOURCE  = libarchive-$(LIBARCHIVE_VERSION).tar.gz
LIBARCHIVE_SITE    = https://www.libarchive.org/downloads
LIBARCHIVE_DEPENDS = bootstrap

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
