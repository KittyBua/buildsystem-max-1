#
# gnutls
#
GNUTLS_VER    = 3.6.10
GNUTLS_DIR    = gnutls-$(GNUTLS_VER)
GNUTLS_SOURCE = gnutls-$(GNUTLS_VER).tar.xz
GNUTLS_SITE   = https://www.gnupg.org/ftp/gcrypt/gnutls/v$(basename $(GNUTLS_VER))

$(D)/gnutls: bootstrap ca-bundle nettle
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--infodir=/.remove \
			--datarootdir=/.remove \
			--with-included-libtasn1 \
			--with-libpthread-prefix=$(TARGET_DIR)/usr \
			--with-included-unistring \
			--with-default-trust-store-dir=$(CA_BUNDLE_DIR)/$(CA_BUNDLE_CRT) \
			--without-p11-kit \
			--without-idn \
			--without-tpm \
			--disable-libdane \
			--disable-rpath \
			--enable-local-libopts \
			--enable-openssl-compatibility \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,psktool gnutls-cli-debug certtool srptool ocsptool gnutls-serv gnutls-cli)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
