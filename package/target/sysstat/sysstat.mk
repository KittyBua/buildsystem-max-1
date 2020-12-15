#
# sysstat
#
SYSSTAT_VER    = 12.5.1
SYSSTAT_DIR    = sysstat-$(SYSSTAT_VER)
SYSSTAT_SOURCE = sysstat-$(SYSSTAT_VER).tar.xz
SYSSTAT_SITE   = http://pagesperso-orange.fr/sebastien.godard

SYSSTAT_PATCH = \
	0001-ldflags.patch

SYSSTAT_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--disable-documentation \
	--disable-largefile \
	--disable-sensors \
	--disable-nls \
	sa_lib_dir="/usr/lib/sysstat" \
	sa_dir="/var/log/sysstat" \
	conf_dir="/etc/sysstat"

$(D)/sysstat: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
