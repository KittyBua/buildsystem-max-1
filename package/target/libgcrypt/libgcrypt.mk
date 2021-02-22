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
	--disable-static \
	--disable-tests \
	--with-gpg-error-prefix=$(TARGET_DIR)/usr

$(D)/libgcrypt:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	mv $(TARGET_DIR)/usr/bin/libgcrypt-config $(HOST_DIR)/bin
	$(REWRITE_CONFIG) $(HOST_DIR)/bin/libgcrypt-config
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
