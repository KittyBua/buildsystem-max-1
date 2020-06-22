#
# openresolv
#
OPENRESOLV_VER    = 3.9.2
OPENRESOLV_DIR    = openresolv-$(OPENRESOLV_VER)
OPENRESOLV_SOURCE = openresolv-$(OPENRESOLV_VER).tar.xz
OPENRESOLV_SITE   = https://roy.marples.name/downloads/openresolv

$(D)/openresolv: bootstrap
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		echo "SYSCONFDIR=/etc" > config.mk; \
		echo "SBINDIR=/sbin" >> config.mk; \
		echo "LIBEXECDIR=/lib/resolvconf" >> config.mk; \
		echo "VARDIR=/var/run/resolvconf" >> config.mk; \
		echo "MANDIR=/.remove" >> config.mk; \
		echo "RCDIR=etc/init.d" >> config.mk; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(PKG_REMOVE)
	$(TOUCH)
