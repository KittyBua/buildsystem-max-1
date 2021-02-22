#
# libgpg-error
#
LIBGPG_ERROR_VER    = 1.37
LIBGPG_ERROR_DIR    = libgpg-error-$(LIBGPG_ERROR_VER)
LIBGPG_ERROR_SOURCE = libgpg-error-$(LIBGPG_ERROR_VER).tar.bz2
LIBGPG_ERROR_SITE   = https://www.gnupg.org/ftp/gcrypt/libgpg-error
LIBGPG_ERROR_DEPS   = bootstrap

LIBGPG_ERROR_AUTORECONF = YES

LIBGPG_ERROR_CONF_OPTS = \
	--localedir=$(REMOVE_localedir) \
	--enable-shared \
	--enable-static \
	--disable-doc \
	--disable-languages \
	--disable-tests

$(D)/libgpg-error:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_CONFIG) $(TARGET_DIR)/usr/bin/gpg-error-config
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,gpg-error gpgrt-config yat2m)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
