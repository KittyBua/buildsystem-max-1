################################################################################
#
# libtirpc
#
################################################################################

LIBTIRPC_VERSION = 1.3.2
LIBTIRPC_DIR     = libtirpc-$(LIBTIRPC_VERSION)
LIBTIRPC_SOURCE  = libtirpc-$(LIBTIRPC_VERSION).tar.bz2
LIBTIRPC_SITE    = https://sourceforge.net/projects/libtirpc/files/libtirpc/$(LIBTIRPC_VERSION)
LIBTIRPC_DEPENDS = bootstrap

LIBTIRPC_AUTORECONF = YES

LIBTIRPC_CONF_ENV = \
	CFLAGS="$(TARGET_CFLAGS) -DGQ"

LIBTIRPC_CONF_OPTS = \
	--disable-gssapi

$(D)/libtirpc:
	$(call make-package)
