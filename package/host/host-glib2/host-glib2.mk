#
# host-glib2
#
HOST_GLIB2_VER    = 2.62.4
HOST_GLIB2_DIR    = glib-$(HOST_GLIB2_VER)
HOST_GLIB2_SOURCE = glib-$(HOST_GLIB2_VER).tar.xz
HOST_GLIB2_SITE   = https://ftp.gnome.org/pub/gnome/sources/glib/$(basename $(HOST_GLIB2_VER))
HOST_GLIB2_DEPS   = bootstrap host-meson host-libffi

$(D)/host-glib2:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		export PKG_CONFIG=/usr/bin/pkg-config; \
		export PKG_CONFIG_PATH=$(HOST_DIR)/lib/pkgconfig; \
		$(HOST_DIR)/bin/meson builddir/ --buildtype=release \
			--prefix=/ \
			-Ddtrace=false \
			-Dfam=false \
			-Dselinux=disabled \
			-Dsystemtap=false \
			-Dxattr=false \
			-Dinternal_pcre=false \
			-Dinstalled_tests=false \
			-Doss_fuzz=disabled \
			; \
	$(PKG_CHDIR); \
		DESTDIR=$(HOST_DIR) $(HOST_DIR)/bin/ninja -C builddir install
	$(REMOVE)
	$(TOUCH)
