#
# ethtool
#
ETHTOOL_VER    = 5.10
ETHTOOL_DIR    = ethtool-$(ETHTOOL_VER)
ETHTOOL_SOURCE = ethtool-$(ETHTOOL_VER).tar.xz
ETHTOOL_SITE   = https://www.kernel.org/pub/software/network/ethtool

ETHTOOL_CONF_OPTS = \
	--disable-pretty-dump \
	--disable-netlink

$(D)/ethtool: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
