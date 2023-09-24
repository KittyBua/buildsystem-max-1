################################################################################
#
# sysstat
#
################################################################################

SYSSTAT_VERSION = 12.7.4
SYSSTAT_DIR = sysstat-$(SYSSTAT_VERSION)
SYSSTAT_SOURCE = sysstat-$(SYSSTAT_VERSION).tar.xz
SYSSTAT_SITE = https://sysstat.github.io/sysstat-packages

SYSSTAT_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--disable-documentation \
	--disable-largefile \
	--disable-sensors \
	--disable-nls \
	sa_lib_dir="/usr/lib/sysstat" \
	sa_dir="/var/log/sysstat" \
	conf_dir="/etc/sysstat"

$(D)/sysstat: | bootstrap
	$(call autotools-package)
