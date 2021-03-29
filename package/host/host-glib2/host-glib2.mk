#
# host-glib2
#
HOST_GLIB2_VERSION = 2.62.4
HOST_GLIB2_DIR     = glib-$(HOST_GLIB2_VERSION)
HOST_GLIB2_SOURCE  = glib-$(HOST_GLIB2_VERSION).tar.xz
HOST_GLIB2_SITE    = https://ftp.gnome.org/pub/gnome/sources/glib/$(basename $(HOST_GLIB2_VERSION))
HOST_GLIB2_DEPENDS = bootstrap host-meson host-libffi

host-glib2:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
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
	$(CD_BUILD_DIR); \
		DESTDIR=$(HOST_DIR) $(HOST_DIR)/bin/ninja -C builddir install
	$(REMOVE)
	$(TOUCH)
