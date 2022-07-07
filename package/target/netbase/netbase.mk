################################################################################
#
# netbase
#
################################################################################

NETBASE_VERSION = 6.3
NETBASE_DIR = netbase-$(NETBASE_VERSION)
NETBASE_SOURCE = netbase_$(NETBASE_VERSION).tar.xz
NETBASE_SITE = https://ftp.debian.org/debian/pool/main/n/netbase

NETBASE_DEPENDS = bootstrap

define NETBASE_INSTALL_FILES
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/etc/rpc $(TARGET_DIR)/etc/rpc; \
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/etc/protocols $(TARGET_DIR)/etc/protocols; \
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/etc/services $(TARGET_DIR)/etc/services
endef
NETBASE_INDIVIDUAL_HOOKS += NETBASE_INSTALL_FILES

$(D)/netbase:
	$(call individual-package)