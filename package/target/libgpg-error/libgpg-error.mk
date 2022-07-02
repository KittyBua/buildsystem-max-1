################################################################################
#
# libgpg-error
#
################################################################################

LIBGPG_ERROR_VERSION = 1.42
LIBGPG_ERROR_DIR     = libgpg-error-$(LIBGPG_ERROR_VERSION)
LIBGPG_ERROR_SOURCE  = libgpg-error-$(LIBGPG_ERROR_VERSION).tar.bz2
LIBGPG_ERROR_SITE    = https://www.gnupg.org/ftp/gcrypt/libgpg-error
LIBGPG_ERROR_DEPENDS = bootstrap

LIBGPG_ERROR_AUTORECONF = YES

LIBGPG_ERROR_CONFIG_SCRIPTS = gpg-error-config

LIBGPG_ERROR_CONF_OPTS = \
	--localedir=$(REMOVE_localedir) \
	--enable-shared \
	--enable-static \
	--disable-doc \
	--disable-languages \
	--disable-tests

define LIBGPG_ERROR_TARGET_CLEANUP
	rm -f $(addprefix $(TARGET_BIN_DIR)/,gpg-error gpgrt-config yat2m)
endef
LIBGPG_ERROR_TARGET_CLEANUP_HOOKS += LIBGPG_ERROR_TARGET_CLEANUP

$(D)/libgpg-error:
	$(call autotools-package)
