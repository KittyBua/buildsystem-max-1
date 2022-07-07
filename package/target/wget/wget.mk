################################################################################
#
# wget
#
################################################################################

WGET_VERSION = 1.21.3
WGET_DIR = wget-$(WGET_VERSION)
WGET_SOURCE = wget-$(WGET_VERSION).tar.gz
WGET_SITE = https://ftp.gnu.org/gnu/wget

WGET_DEPENDS = bootstrap openssl

WGET_CFLAGS = $(TARGET_CFLAGS) -DOPENSSL_NO_ENGINE

WGET_CONF_OPTS = \
	--infodir=$(REMOVE_infodir) \
	--with-ssl=openssl \
	--disable-ipv6 \
	--disable-debug \
	--disable-nls \
	--disable-opie \
	--disable-digest \
	--disable-rpath \
	--disable-iri \
	--disable-pcre \
	--without-libpsl \
	CFLAGS="$(WGET_CFLAGS)"

$(D)/wget:
	$(call autotools-package)
