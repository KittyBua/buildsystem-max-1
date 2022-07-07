################################################################################
#
# host-meson
#
################################################################################

HOST_MESON_VERSION = 0.58.1
HOST_MESON_DIR = meson-$(HOST_MESON_VERSION)
HOST_MESON_SOURCE = meson-$(HOST_MESON_VERSION).tar.gz
HOST_MESON_SITE = https://github.com/mesonbuild/meson/releases/download/$(HOST_MESON_VERSION)

HOST_MESON_DEPENDS = bootstrap host-ninja host-python3 host-python3-setuptools

HOST_MESON_BINARY = $(HOST_DIR)/bin/meson

$(D)/host-meson:
	$(call host-python3-package)
