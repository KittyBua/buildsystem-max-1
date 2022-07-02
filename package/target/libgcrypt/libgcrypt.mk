################################################################################
#
# libgcrypt
#
################################################################################

LIBGCRYPT_VERSION = 1.10.1
LIBGCRYPT_DIR     = libgcrypt-$(LIBGCRYPT_VERSION)
LIBGCRYPT_SOURCE  = libgcrypt-$(LIBGCRYPT_VERSION).tar.bz2
LIBGCRYPT_SITE    = https://gnupg.org/ftp/gcrypt/libgcrypt
LIBGCRYPT_DEPENDS = bootstrap libgpg-error

LIBGCRYPT_CONFIG_SCRIPTS = libgcrypt-config

LIBGCRYPT_CONF_OPTS = \
	--enable-shared \
	--disable-static \
	--disable-tests

define LIBGCRYPT_TARGET_CLEANUP
	rm -rf $(addprefix $(TARGET_bindir)/,dumpsexp hmac256 mpicalc)
endef
LIBGCRYPT_TARGET_CLEANUP_HOOKS += LIBGCRYPT_TARGET_CLEANUP

$(D)/libgcrypt:
	$(call autotools-package)
