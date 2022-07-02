################################################################################
#
# libnl
#
################################################################################

LIBNL_VERSION = 3.5.0
LIBNL_DIR     = libnl-$(LIBNL_VERSION)
LIBNL_SOURCE  = libnl-$(LIBNL_VERSION).tar.gz
LIBNL_SITE    = https://github.com/thom311/libnl/releases/download/libnl$(subst .,_,$(LIBNL_VERSION))
LIBNL_DEPENDS = bootstrap

LIBNL_CONF_OPTS = \
	--disable-cli

$(D)/libnl:
	$(call autotools-package)
