################################################################################
#
# libdav1d
#
################################################################################

LIBDAV1D_VERSION = git
LIBDAV1D_DIR     = dav1d.git
LIBDAV1D_SOURCE  = dav1d.git
LIBDAV1D_SITE    = https://code.videolan.org/videolan

LIBDAV1D_DEPENDS = host-meson

$(D)/libdav1d: | bootstrap
	$(call meson-package)
