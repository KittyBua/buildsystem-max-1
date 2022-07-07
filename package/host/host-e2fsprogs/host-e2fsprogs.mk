################################################################################
#
# host-e2fsprogs
#
################################################################################

HOST_E2FSPROGS_VERSION = $(E2FSPROGS_VERSION)
HOST_E2FSPROGS_DIR = e2fsprogs-$(HOST_E2FSPROGS_VERSION)
HOST_E2FSPROGS_SOURCE = e2fsprogs-$(HOST_E2FSPROGS_VERSION).tar.gz
HOST_E2FSPROGS_SITE = https://sourceforge.net/projects/e2fsprogs/files/e2fsprogs/v$(HOST_E2FSPROGS_VERSION)

HOST_E2FSPROGS_DEPENDS = bootstrap

HOST_E2FSPROGS_CONF_OPTS = \
	--enable-symlink-install \
	--with-crond-dir=no

$(D)/host-e2fsprogs:
	$(call host-autotools-package)
