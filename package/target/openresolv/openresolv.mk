################################################################################
#
# openresolv
#
################################################################################

OPENRESOLV_VERSION = 3.13.1
OPENRESOLV_DIR = openresolv-$(OPENRESOLV_VERSION)
OPENRESOLV_SOURCE = openresolv-$(OPENRESOLV_VERSION).tar.xz
OPENRESOLV_SITE = https://github.com/NetworkConfiguration/openresolv/releases/download/v$(OPENRESOLV_VERSION)

define OPENRESOLV_CREATE_CONF_ENV_FILE
	echo "SYSCONFDIR=/etc"             > $(PKG_BUILD_DIR)/config.mk
	echo "SBINDIR=/sbin"              >> $(PKG_BUILD_DIR)/config.mk
	echo "LIBEXECDIR=/lib/resolvconf" >> $(PKG_BUILD_DIR)/config.mk
	echo "VARDIR=/var/run/resolvconf" >> $(PKG_BUILD_DIR)/config.mk
	echo "MANDIR=$(REMOVE_mandir)"    >> $(PKG_BUILD_DIR)/config.mk
	echo "RCDIR=etc/init.d"           >> $(PKG_BUILD_DIR)/config.mk
endef
OPENRESOLV_POST_PATCH_HOOKS += OPENRESOLV_CREATE_CONF_ENV_FILE

$(D)/openresolv: | bootstrap
	$(call generic-package)
