################################################################################
#
# host-libffi
#
################################################################################

HOST_LIBFFI_VERSION = 3.4.2
HOST_LIBFFI_DIR     = libffi-$(HOST_LIBFFI_VERSION)
HOST_LIBFFI_SOURCE  = libffi-$(HOST_LIBFFI_VERSION).tar.gz
HOST_LIBFFI_SITE    = https://github.com/libffi/libffi/releases/download/v$(HOST_LIBFFI_VERSION)
HOST_LIBFFI_DEPENDS = bootstrap

HOST_LIBFFI_CONF_OPTS = \
	--disable-static

$(D)/host-libffi:
	$(call host-make-package)
