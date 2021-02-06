#
# libcurl
#
LIBCURL_VER    = 7.74.0
LIBCURL_DIR    = curl-$(LIBCURL_VER)
LIBCURL_SOURCE = curl-$(LIBCURL_VER).tar.bz2
LIBCURL_SITE   = https://curl.haxx.se/download
LIBCURL_DEPS   = bootstrap zlib openssl ca-bundle

LIBCURL_AUTORECONF = YES

LIBCURL_CONF_OPTS = \
	--enable-silent-rules \
	--disable-debug \
	--disable-curldebug \
	--disable-manual \
	--disable-file \
	--disable-rtsp \
	--disable-dict \
	--disable-imap \
	--disable-pop3 \
	--disable-smtp \
	--enable-shared \
	--enable-optimize \
	--disable-verbose \
	--disable-ldap \
	--without-libidn \
	--without-libidn2 \
	--without-winidn \
	--without-libpsl \
	--without-zstd \
	--with-ca-bundle=$(CA_BUNDLE_DIR)/$(CA_BUNDLE_CRT) \
	--with-random=/dev/urandom \
	--with-ssl=$(TARGET_DIR)/usr

$(D)/libcurl:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/bin/curl-config $(HOST_DIR)/bin/
	$(REWRITE_CONFIG) $(HOST_DIR)/bin/curl-config
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
