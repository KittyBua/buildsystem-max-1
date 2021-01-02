#
# libgpg-error
#
LIBGPG_ERROR_VER    = 1.37
LIBGPG_ERROR_DIR    = libgpg-error-$(LIBGPG_ERROR_VER)
LIBGPG_ERROR_SOURCE = libgpg-error-$(LIBGPG_ERROR_VER).tar.bz2
LIBGPG_ERROR_SITE   = https://www.gnupg.org/ftp/gcrypt/libgpg-error

LIBGPG_ERROR_CONF_OPTS = \
	--localedir=$(REMOVE_localedir) \
	--enable-shared \
	--enable-static \
	--disable-doc \
	--disable-languages \
	--disable-tests

$(D)/libgpg-error: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		autoreconf -fi; \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_CONFIG) $(TARGET_DIR)/usr/bin/gpg-error-config
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,gpg-error gpgrt-config yat2m)
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
