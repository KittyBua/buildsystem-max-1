#
# host-glib2
#
HOST_GLIB2_VER    = 2.56.3
HOST_GLIB2_DIR    = glib-$(HOST_GLIB2_VER)
HOST_GLIB2_SOURCE = glib-$(HOST_GLIB2_VER).tar.xz
HOST_GLIB2_SITE   = https://ftp.gnome.org/pub/gnome/sources/glib/$(basename $(HOST_GLIB2_VER))

HOST_GLIB2_PATCH  = \
	0004-gdbus-Avoid-printing-null-strings.patch

$(D)/host-glib2: bootstrap host-libffi
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		export PKG_CONFIG=/usr/bin/pkg-config; \
		export PKG_CONFIG_PATH=$(HOST_DIR)/lib/pkgconfig; \
		$(call apply_patches, $(PKG_PATCH)); \
		./configure $(SILENT_OPT) \
			--prefix=`pwd`/out \
			--enable-static=yes \
			--enable-shared=no \
			--disable-fam \
			--disable-libmount \
			--with-pcre=internal \
			; \
		$(MAKE) install; \
		cp -a out/bin/glib-* $(HOST_DIR)/bin
	$(PKG_REMOVE)
	$(TOUCH)
