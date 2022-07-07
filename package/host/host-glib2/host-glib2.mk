################################################################################
#
# host-glib2
#
################################################################################

HOST_GLIB2_VERSION =$(GLIB2_VERSION)
HOST_GLIB2_DIR = glib-$(HOST_GLIB2_VERSION)
HOST_GLIB2_SOURCE = glib-$(HOST_GLIB2_VERSION).tar.xz
HOST_GLIB2_SITE = https://ftp.gnome.org/pub/gnome/sources/glib/$(basename $(HOST_GLIB2_VERSION))

HOST_GLIB2_DEPENDS = bootstrap host-meson host-libffi

HOST_GLIB2_CONF_OPTS = \
	-Ddtrace=false \
	-Dfam=false \
	-Dselinux=disabled \
	-Dsystemtap=false \
	-Dxattr=false \
	-Dinternal_pcre=false \
	-Dinstalled_tests=false \
	-Doss_fuzz=disabled

$(D)/host-glib2:
	$(call host-meson-package)
