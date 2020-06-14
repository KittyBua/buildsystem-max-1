#
# gnutls
#
GNUTLS_VER    = 3.6.10
GNUTLS_DIR    = gnutls-$(GNUTLS_VER)
GNUTLS_SOURCE = gnutls-$(GNUTLS_VER).tar.xz
GNUTLS_URL    = https://www.gnupg.org/ftp/gcrypt/gnutls/v$(basename $(GNUTLS_VER))

$(D)/gnutls: bootstrap ca-bundle nettle
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--infodir=/.remove \
			--datarootdir=/.remove \
			--with-included-libtasn1 \
			--with-libpthread-prefix=$(TARGET_DIR)/usr \
			--with-included-unistring \
			--with-default-trust-store-dir=$(CA_BUNDLE_DIR)/ca-certificates.crt \
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
	$(REWRITE_LIBTOOL_LA)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,psktool gnutls-cli-debug certtool srptool ocsptool gnutls-serv gnutls-cli)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
