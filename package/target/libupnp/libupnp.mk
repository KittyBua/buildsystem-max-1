################################################################################
#
# libupnp
#
################################################################################

LIBUPNP_VERSION = 1.6.25
LIBUPNP_DIR = libupnp-$(LIBUPNP_VERSION)
LIBUPNP_SOURCE = libupnp-$(LIBUPNP_VERSION).tar.bz2
LIBUPNP_SITE = http://sourceforge.net/projects/pupnp/files/pupnp/libUPnP%20$(LIBUPNP_VERSION)

LIBUPNP_DEPENDS = bootstrap

LIBUPNP_CONF_ENV = \
	ac_cv_lib_compat_ftime=no

LIBUPNP_CONF_OPTS = \
	--enable-shared \
	--disable-static \
	--disable-samples \
	--enable-reuseaddr

$(D)/libupnp:
	$(call autotools-package)
