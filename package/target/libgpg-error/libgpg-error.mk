#
# libgpg-error
#
LIBGPG_ERROR_VER    = 1.37
LIBGPG_ERROR_DIR    = libgpg-error-$(LIBGPG_ERROR_VER)
LIBGPG_ERROR_SOURCE = libgpg-error-$(LIBGPG_ERROR_VER).tar.bz2
LIBGPG_ERROR_SITE   = https://www.gnupg.org/ftp/gcrypt/libgpg-error

$(D)/libgpg-error: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-shared \
			--enable-static \
			--disable-doc \
			--disable-languages \
			--disable-tests \
			--datarootdir=/.remove \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_CONFIG) $(TARGET_DIR)/usr/bin/gpg-error-config
	$(REWRITE_LIBTOOL_LA)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,gpg-error gpgrt-config yat2m)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
