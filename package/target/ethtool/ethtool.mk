#
# ethtool
#
ETHTOOL_VER    = 5.10
ETHTOOL_DIR    = ethtool-$(ETHTOOL_VER)
ETHTOOL_SOURCE = ethtool-$(ETHTOOL_VER).tar.xz
ETHTOOL_SITE   = https://www.kernel.org/pub/software/network/ethtool
ETHTOOL_DEPS   = bootstrap

ETHTOOL_CONF_OPTS = \
	--disable-pretty-dump \
	--disable-netlink

$(D)/ethtool:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
