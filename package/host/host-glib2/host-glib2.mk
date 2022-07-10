################################################################################
#
# host-glib2
#
################################################################################

HOST_GLIB2_DEPENDS = host-meson host-libffi

HOST_GLIB2_CONF_OPTS = \
	-Ddtrace=false \
	-Dfam=false \
	-Dselinux=disabled \
	-Dsystemtap=false \
	-Dxattr=false \
	-Dinternal_pcre=false \
	-Dinstalled_tests=false \
	-Doss_fuzz=disabled

$(D)/host-glib2: | bootstrap
	$(call host-meson-package)
