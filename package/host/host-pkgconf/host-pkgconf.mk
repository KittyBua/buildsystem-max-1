################################################################################
#
# host-pkgconf
#
################################################################################

HOST_PKGCONF_VERSION = 1.8.0
HOST_PKGCONF_DIR = pkgconf-$(HOST_PKGCONF_VERSION)
HOST_PKGCONF_SOURCE = pkgconf-$(HOST_PKGCONF_VERSION).tar.xz
HOST_PKGCONF_SITE = https://distfiles.dereferenced.org/pkgconf

HOST_PKGCONF_DEPENDS = directories

PKG_CONFIG_HOST_BINARY = $(HOST_DIR)/bin/pkg-config

define HOST_PKGCONF_INSTALL_FILES
	$(INSTALL_EXEC) $(PKG_FILES_DIR)/pkgconf-config $(HOST_DIR)/bin/pkg-config
	ln -sf pkg-config $(HOST_DIR)/bin/$(GNU_TARGET_NAME)-pkg-config
endef
HOST_PKGCONF_POST_INSTALL_HOOKS += HOST_PKGCONF_INSTALL_FILES

$(D)/host-pkgconf:
	$(call host-autotools-package)
