################################################################################
#
# gnutls
#
################################################################################

GNUTLS_VERSION = 3.6.10
GNUTLS_DIR     = gnutls-$(GNUTLS_VERSION)
GNUTLS_SOURCE  = gnutls-$(GNUTLS_VERSION).tar.xz
GNUTLS_SITE    = https://www.gnupg.org/ftp/gcrypt/gnutls/v$(basename $(GNUTLS_VERSION))
GNUTLS_DEPENDS = bootstrap ca-bundle nettle

GNUTLS_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--localedir=$(REMOVE_localedir) \
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
	--enable-openssl-compatibility

define GNUTLS_CLEANUP_TARGET
	rm -f $(addprefix $(TARGET_BIN_DIR)/,psktool gnutls-cli-debug certtool srptool ocsptool gnutls-serv gnutls-cli)
endef
GNUTLS_CLEANUP_TARGET_HOOKS += GNUTLS_CLEANUP_TARGET

$(D)/gnutls:
	$(call autotools-package)
