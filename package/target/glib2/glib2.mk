#
# glib2
#
GLIB2_VER    = 2.56.3
GLIB2_DIR    = glib-$(GLIB2_VER)
GLIB2_SOURCE = glib-$(GLIB2_VER).tar.xz
GLIB2_URL    = https://ftp.gnome.org/pub/gnome/sources/glib/$(basename $(GLIB2_VER))

GLIB2_PATCH  = \
	0001-glib2-disable-tests.patch \
	0002-glib2-automake.patch \
	0003-glib2-fix-gio-linking.patch \
	0004-gdbus-Avoid-printing-null-strings.patch

$(D)/glib2: bootstrap host-glib2 libffi util-linux zlib libiconv
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		echo "glib_cv_va_copy=no" > config.cache; \
		echo "glib_cv___va_copy=yes" >> config.cache; \
		echo "glib_cv_va_val_copy=yes" >> config.cache; \
		echo "ac_cv_func_posix_getpwuid_r=yes" >> config.cache; \
		echo "ac_cv_func_posix_getgrgid_r=yes" >> config.cache; \
		echo "glib_cv_stack_grows=no" >> config.cache; \
		echo "glib_cv_uscore=no" >> config.cache; \
		echo "ac_cv_path_GLIB_GENMARSHAL=$(HOST_DIR)/bin/glib-genmarshal" >> config.cache; \
		$(CONFIGURE) \
			--prefix=/usr \
			--enable-static \
			--mandir=/.remove \
			--cache-file=config.cache \
			--disable-fam \
			--disable-libmount \
			--disable-gtk-doc \
			--disable-gtk-doc-html \
			--disable-gtk-doc-pdf \
			--with-threads="posix" \
			--with-html-dir=/.remove \
			--with-pcre=internal \
			--with-libiconv=gnu \
			; \
		$(MAKE) all; \
		$(MAKE) install DESTDIR=$(TARGET_DIR) localedir=/.remove/locale gnulocaledir=/.remove/locale
	$(REWRITE_LIBTOOL_LA)
	rm -rf $(addprefix $(TARGET_DIR)/usr/share/,gettext gdb glib-2.0)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,gdbus-codegen glib-compile-schemas glib-compile-resources glib-genmarshal glib-gettextize glib-mkenums gobject-query gtester gtester-report)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
