#
# netbase
#
NETBASE_VER    = 6.1
NETBASE_DIR    = netbase-$(NETBASE_VER)
NETBASE_SOURCE = netbase_$(NETBASE_VER).tar.xz
NETBASE_SITE   = http://ftp.debian.org/debian/pool/main/n/netbase/


NETBASE_PATCH = \
	0001-netbase-add-rpcbind-as-an-alias-to-sunrpc.patch

$(D)/netbase: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(INSTALL_DATA) etc/rpc $(TARGET_DIR)/etc/rpc; \
		$(INSTALL_DATA) etc/protocols $(TARGET_DIR)/etc/protocols; \
		$(INSTALL_DATA) etc/services $(TARGET_DIR)/etc/services
	$(PKG_REMOVE)
	$(TOUCH)
