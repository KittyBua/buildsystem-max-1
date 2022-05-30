################################################################################
#
# libfuse3
#
################################################################################

LIBFUSE3_VERSION = 3.10.5
LIBFUSE3_DIR     = fuse-$(LIBFUSE3_VERSION)
LIBFUSE3_SOURCE  = fuse-$(LIBFUSE3_VERSION).tar.xz
LIBFUSE3_SITE    = https://github.com/libfuse/libfuse/releases/download/fuse-$(LIBFUSE3_VERSION)
LIBFUSE3_DEPENDS = bootstrap host-meson

LIBFUSE3_CONF_OPTS = \
	-Ddisable-mtab=true \
	-Dudevrulesdir=/dev/null \
	-Dutils=false \
	-Dexamples=false \
	-Duseroot=false

$(D)/libfuse3:
	$(call meson-package)
