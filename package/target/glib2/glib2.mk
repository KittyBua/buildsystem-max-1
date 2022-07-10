################################################################################
#
# glib2
#
################################################################################

GLIB2_VERSION = 2.62.4
GLIB2_DIR = glib-$(GLIB2_VERSION)
GLIB2_SOURCE = glib-$(GLIB2_VERSION).tar.xz
GLIB2_SITE = https://ftp.gnome.org/pub/gnome/sources/glib/$(basename $(GLIB2_VERSION))

GLIB2_DEPENDS = host-glib2 libffi util-linux zlib libiconv

GLIB2_CONF_OPTS = \
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

define GLIB2_TARGET_CLEANUP
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,gettext gdb glib-2.0 locale)
	rm -f $(addprefix $(TARGET_BIN_DIR)/,gdbus-codegen glib-compile-schemas glib-compile-resources glib-genmarshal glib-gettextize gio-launch-desktop glib-mkenums gobject-query gtester gtester-report)
endef
GLIB2_TARGET_CLEANUP_HOOKS += GLIB2_TARGET_CLEANUP

$(D)/glib2: | bootstrap
	$(call meson-package)
