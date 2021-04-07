#
# libiconv
#
LIBICONV_VERSION = 1.13.1
LIBICONV_DIR     = libiconv-$(LIBICONV_VERSION)
LIBICONV_SOURCE  = libiconv-$(LIBICONV_VERSION).tar.gz
LIBICONV_SITE    = https://ftp.gnu.org/gnu/libiconv
LIBICONV_DEPENDS = bootstrap

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
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	rm -f $(addprefix $(TARGET_LIB_DIR)/,preloadable_libiconv.so)
	$(TOUCH)
