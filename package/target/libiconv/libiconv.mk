#
# libiconv
#
LIBICONV_VER    = 1.13.1
LIBICONV_DIR    = libiconv-$(LIBICONV_VER)
LIBICONV_SOURCE = libiconv-$(LIBICONV_VER).tar.gz
LIBICONV_SITE   = https://ftp.gnu.org/gnu/libiconv
LIBICONV_DEPS   = bootstrap

LIBICONV_CONF_OPTS = \
	CPPFLAGS="$(TARGET_CPPFLAGS) -fPIC" \
	--docdir=$(REMOVE_docdir) \
	--localedir=$(REMOVE_localedir) \
	--enable-static \
	--disable-shared \
	--enable-relocatable

$(D)/libiconv:
	$(START_BUILD)
	$(REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -f $(addprefix $(TARGET_LIB_DIR)/,preloadable_libiconv.so)
	$(REWRITE_LIBTOOL_LA)
	$(REMOVE)
	$(TOUCH)
