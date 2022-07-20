################################################################################
#
# libcurl
#
################################################################################

LIBCURL_VERSION = 7.84.0
LIBCURL_DIR = curl-$(LIBCURL_VERSION)
LIBCURL_SOURCE = curl-$(LIBCURL_VERSION).tar.bz2
LIBCURL_SITE = https://curl.haxx.se/download

LIBCURL_DEPENDS = zlib openssl ca-bundle

LIBCURL_CONFIG_SCRIPTS = curl-config

LIBCURL_CONF_OPTS = \
	--enable-silent-rules \
	--disable-debug \
	--disable-manual \
	--disable-file \
	--disable-rtsp \
	--disable-dict \
	--disable-ldap \
	--disable-curldebug \
	--disable-imap \
	--disable-pop3 \
	--disable-smtp \
	--enable-shared \
	--disable-verbose \
	--without-libidn \
	--without-libidn2 \
	--without-winidn \
	--without-libpsl \
	--without-zstd \
	--with-ca-bundle=$(CA_BUNDLE_DIR)/$(CA_BUNDLE_CRT) \
	--with-random=/dev/urandom \
	--with-ssl=$(TARGET_DIR)/usr \
	--enable-optimize

$(D)/libcurl: | bootstrap
	$(call autotools-package)
