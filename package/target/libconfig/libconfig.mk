################################################################################
#
# libconfig
#
################################################################################

LIBCONFIG_VERSION = 1.4.10
LIBCONFIG_DIR     = libconfig-$(LIBCONFIG_VERSION)
LIBCONFIG_SOURCE  = libconfig-$(LIBCONFIG_VERSION).tar.gz
LIBCONFIG_SITE    = http://www.hyperrealm.com/packages
LIBCONFIG_DEPENDS = bootstrap

LIBCONFIG_CONF_OPTS = \
	--disable-static

$(D)/libconfig:
	$(call autotools-package)
