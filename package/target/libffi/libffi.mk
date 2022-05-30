################################################################################
#
# libffi
#
################################################################################

LIBFFI_VERSION = 3.4.2
LIBFFI_DIR     = libffi-$(LIBFFI_VERSION)
LIBFFI_SOURCE  = libffi-$(LIBFFI_VERSION).tar.gz
LIBFFI_SITE    = https://github.com/libffi/libffi/releases/download/v$(LIBFFI_VERSION)
LIBFFI_DEPENDS = bootstrap

LIBFFI_AUTORECONF = YES

LIBFFI_CONF_OPTS = \
	--disable-static \
	--enable-builddir=libffi

$(D)/libffi:
	$(call make-package)
