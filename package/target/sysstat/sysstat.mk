#
# sysstat
#
SYSSTAT_VER    = 12.5.1
SYSSTAT_DIR    = sysstat-$(SYSSTAT_VER)
SYSSTAT_SOURCE = sysstat-$(SYSSTAT_VER).tar.xz
SYSSTAT_SITE   = http://pagesperso-orange.fr/sebastien.godard
SYSSTAT_DEPS   = bootstrap

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
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
