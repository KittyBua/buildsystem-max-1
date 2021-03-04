#
# cairo
#
CAIRO_VER    = 1.16.0
CAIRO_DIR    = cairo-$(CAIRO_VER)
CAIRO_SOURCE = cairo-$(CAIRO_VER).tar.xz
CAIRO_SITE   = https://www.cairographics.org/releases
CAIRO_DEPS   = bootstrap glib2 zlib libpng freetype pixman

CAIRO_CONF_ENV = \
	ax_cv_c_float_words_bigendian="no"

CAIRO_CONF_OPTS = \
	--with-html-dir=$(REMOVE_htmldir) \
	--with-x=no \
	--disable-xlib \
	--disable-xcb \
	--disable-egl \
	--disable-glesv2 \
	--disable-gl \
	--enable-tee

$(D)/cairo:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -rf $(TARGET_DIR)/usr/bin/cairo-sphinx
	rm -rf $(TARGET_LIB_DIR)/cairo/cairo-fdr*
	rm -rf $(TARGET_LIB_DIR)/cairo/cairo-sphinx*
	rm -rf $(TARGET_LIB_DIR)/cairo/.debug/cairo-fdr*
	rm -rf $(TARGET_LIB_DIR)/cairo/.debug/cairo-sphinx*
	$(REWRITE_LIBTOOL)
	$(REMOVE)
	$(TOUCH)
