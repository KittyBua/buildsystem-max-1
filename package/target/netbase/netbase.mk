################################################################################
#
# netbase
#
################################################################################

NETBASE_VERSION = 6.3
NETBASE_DIR     = netbase-$(NETBASE_VERSION)
NETBASE_SOURCE  = netbase_$(NETBASE_VERSION).tar.xz
NETBASE_SITE    = https://ftp.debian.org/debian/pool/main/n/netbase
NETBASE_DEPENDS = bootstrap

$(D)/netbase:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(INSTALL_DATA) etc/rpc $(TARGET_DIR)/etc/rpc; \
		$(INSTALL_DATA) etc/protocols $(TARGET_DIR)/etc/protocols; \
		$(INSTALL_DATA) etc/services $(TARGET_DIR)/etc/services
	$(call TARGET_FOLLOWUP)
