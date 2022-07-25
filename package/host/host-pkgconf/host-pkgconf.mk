################################################################################
#
# host-pkgconf
#
################################################################################

PKGCONF_VERSION = 1.8.0
PKGCONF_DIR = pkgconf-$(PKGCONF_VERSION)
PKGCONF_SOURCE = pkgconf-$(PKGCONF_VERSION).tar.xz
PKGCONF_SITE = https://distfiles.dereferenced.org/pkgconf

PKG_CONFIG_HOST_BINARY = $(HOST_DIR)/bin/pkg-config

define HOST_PKGCONF_INSTALL_FILES
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/pkgconf-config $(HOST_DIR)/bin/pkg-config
	ln -sf pkg-config $(HOST_DIR)/bin/$(GNU_TARGET_NAME)-pkg-config
endef
HOST_PKGCONF_POST_INSTALL_HOOKS += HOST_PKGCONF_INSTALL_FILES

$(D)/host-pkgconf: | directories
	$(call host-autotools-package)
