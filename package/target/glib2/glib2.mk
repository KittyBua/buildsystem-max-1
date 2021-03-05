#
# glib2
#
GLIB2_VER    = 2.62.4
GLIB2_DIR    = glib-$(GLIB2_VER)
GLIB2_SOURCE = glib-$(GLIB2_VER).tar.xz
GLIB2_SITE   = https://ftp.gnome.org/pub/gnome/sources/glib/$(basename $(GLIB2_VER))
GLIB2_DEPS   = bootstrap host-glib2 libffi util-linux zlib libiconv

GLIB2_CONF_OPTS = \
	--prefix=/usr \
	-Dman=false \
	-Ddtrace=false \
	-Dsystemtap=false \
	-Dgtk_doc=false \
	-Dinternal_pcre=true \
	-Diconv=external \
	-Dgio_module_dir=/usr/lib/gio/modules \
	-Dinstalled_tests=false \
	-Doss_fuzz=disabled \
	-Dselinux=disabled

$(D)/glib2:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(MESON_CONFIGURE) \
		$($(PKG)_CONF_OPTS); \
		$(NINJA); \
		$(NINJA_INSTALL)
	rm -rf $(addprefix $(TARGET_DIR)/usr/share/,gettext gdb glib-2.0 locale)
	rm -f $(addprefix $(TARGET_DIR)/usr/bin/,gdbus-codegen glib-compile-schemas glib-compile-resources glib-genmarshal glib-gettextize gio-launch-desktop glib-mkenums gobject-query gtester gtester-report)
	$(REMOVE)
	$(TOUCH)
