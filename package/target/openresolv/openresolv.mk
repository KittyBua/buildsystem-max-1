################################################################################
#
# openresolv
#
################################################################################

OPENRESOLV_VERSION = 3.12.0
OPENRESOLV_DIR = openresolv-openresolv-$(OPENRESOLV_VERSION)
OPENRESOLV_SOURCE = openresolv-$(OPENRESOLV_VERSION).tar.gz
OPENRESOLV_SITE = https://github.com/rsmarples/openresolv/archive

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
