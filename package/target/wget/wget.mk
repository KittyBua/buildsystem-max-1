#
# wget
#
WGET_VER    = 1.20.3
WGET_DIR    = wget-$(WGET_VER)
WGET_SOURCE = wget-$(WGET_VER).tar.gz
WGET_SITE   = https://ftp.gnu.org/gnu/wget

WGET_PATCH = \
	0001-change_DEFAULT_LOGFILE.patch \
	0002-set-check_cert-false-by-default.patch \
	0003-wget-improve-reproducibility.patch \
	0004-wget-Strip-long-version-output.patch

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

$(D)/wget: bootstrap openssl
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches,$(PKG_PATCH)); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
