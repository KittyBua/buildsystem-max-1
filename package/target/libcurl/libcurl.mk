#
# libcurl
#
LIBCURL_VER    = 7.73.0
LIBCURL_DIR    = curl-$(LIBCURL_VER)
LIBCURL_SOURCE = curl-$(LIBCURL_VER).tar.bz2
LIBCURL_SITE   = https://curl.haxx.se/download

LIBCURL_PATCH  = \
	0001-no_docs_tests.patch

$(D)/libcurl: bootstrap zlib openssl ca-bundle
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
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
			--with-ssl=$(TARGET_DIR)/usr \
			; \
		$(MAKE) all; \
		sed -e "s,^prefix=,prefix=$(TARGET_DIR)," < curl-config > $(HOST_DIR)/bin/curl-config; \
		chmod 755 $(HOST_DIR)/bin/curl-config; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(TARGET_DIR)/usr/bin/curl-config
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
