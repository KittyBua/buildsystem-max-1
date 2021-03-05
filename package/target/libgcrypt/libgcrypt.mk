#
# libgcrypt
#
LIBGCRYPT_VER    = 1.8.5
LIBGCRYPT_DIR    = libgcrypt-$(LIBGCRYPT_VER)
LIBGCRYPT_SOURCE = libgcrypt-$(LIBGCRYPT_VER).tar.bz2
LIBGCRYPT_SITE   = https://gnupg.org/ftp/gcrypt/libgcrypt
LIBGCRYPT_DEPS   = bootstrap libgpg-error

LIBGCRYPT_CONF_OPTS = \
	--enable-shared \
	--disable-static

LIBGCRYPT_CONFIG_SCRIPTS = libgcrypt-config

$(D)/libgcrypt:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_CONFIG_SCRIPTS)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
