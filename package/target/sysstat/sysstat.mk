################################################################################
#
# sysstat
#
################################################################################

SYSSTAT_VERSION = 12.5.1
SYSSTAT_DIR = sysstat-$(SYSSTAT_VERSION)
SYSSTAT_SOURCE = sysstat-$(SYSSTAT_VERSION).tar.xz
SYSSTAT_SITE = http://pagesperso-orange.fr/sebastien.godard

SYSSTAT_DEPENDS = bootstrap

SYSSTAT_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--disable-documentation \
	--disable-largefile \
	--disable-sensors \
	--disable-nls \
	sa_lib_dir="/usr/lib/sysstat" \
	sa_dir="/var/log/sysstat" \
	conf_dir="/etc/sysstat"

$(D)/sysstat:
	$(call autotools-package)
