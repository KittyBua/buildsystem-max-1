#
# openresolv
#
OPENRESOLV_VER    = 3.9.2
OPENRESOLV_DIR    = openresolv-$(OPENRESOLV_VER)
OPENRESOLV_SOURCE = openresolv-$(OPENRESOLV_VER).tar.xz
OPENRESOLV_URL    = https://roy.marples.name/downloads/openresolv

$(D)/openresolv: bootstrap
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		echo "SYSCONFDIR=/etc" > config.mk; \
		echo "SBINDIR=/sbin" >> config.mk; \
		echo "LIBEXECDIR=/lib/resolvconf" >> config.mk; \
		echo "VARDIR=/var/run/resolvconf" >> config.mk; \
		echo "MANDIR=/.remove" >> config.mk; \
		echo "RCDIR=etc/init.d" >> config.mk; \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
