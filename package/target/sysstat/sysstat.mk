#
# sysstat
#
SYSSTAT_VER    = 12.4.0
SYSSTAT_DIR    = sysstat-$(SYSSTAT_VER)
SYSSTAT_SOURCE = sysstat-$(SYSSTAT_VER).tar.xz
SYSSTAT_SITE   = http://pagesperso-orange.fr/sebastien.godard

SYSSTAT_PATCH  = \
	0001-ldflags.patch

$(D)/sysstat: bootstrap
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(CONFIGURE) \
			--prefix=/usr \
			--mandir=/.remove \
			--docdir=/.remove \
			--disable-documentation \
			--disable-largefile \
			--disable-sensors \
			--disable-nls \
			sa_lib_dir="/usr/lib/sysstat" \
			sa_dir="/var/log/sysstat" \
			conf_dir="/etc/sysstat" \
			; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR) NLS_DIR=/.remove/locale
	$(PKG_REMOVE)
	$(TOUCH)
