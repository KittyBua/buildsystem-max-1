################################################################################
#
# ethtool
#
################################################################################

ETHTOOL_VERSION = 5.17
ETHTOOL_DIR     = ethtool-$(ETHTOOL_VERSION)
ETHTOOL_SOURCE  = ethtool-$(ETHTOOL_VERSION).tar.xz
ETHTOOL_SITE    = https://www.kernel.org/pub/software/network/ethtool
ETHTOOL_DEPENDS = bootstrap

ETHTOOL_CONF_OPTS = \
	--disable-pretty-dump \
	--disable-netlink

$(D)/ethtool:
	$(call make-package)
