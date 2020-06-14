#
# libiconv
#
LIBICONV_VER    = 1.13.1
LIBICONV_DIR    = libiconv-$(LIBICONV_VER)
LIBICONV_SOURCE = libiconv-$(LIBICONV_VER).tar.gz
LIBICONV_URL    = https://ftp.gnu.org/gnu/libiconv

LIBICONV_PATCH  = \
	0001-disable_transliterations.patch \
	0002-strip_charsets.patch

$(D)/libiconv: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CONFIGURE) CPPFLAGS="$(TARGET_CPPFLAGS) -fPIC" \
			--target=$(TARGET) \
			--prefix=/usr \
			--datarootdir=/.remove \
			--enable-static \
			--disable-shared \
			--enable-relocatable \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL_LA)
	rm -f $(addprefix $(TARGET_LIB_DIR)/,preloadable_libiconv.so)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
