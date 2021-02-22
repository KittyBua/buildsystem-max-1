#
# openresolv
#
OPENRESOLV_VER    = 3.12.0
OPENRESOLV_DIR    = openresolv-openresolv-$(OPENRESOLV_VER)
OPENRESOLV_SOURCE = openresolv-$(OPENRESOLV_VER).tar.gz
OPENRESOLV_SITE   = https://github.com/rsmarples/openresolv/archive
OPENRESOLV_DEPS   = bootstrap

$(D)/openresolv:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		echo "SYSCONFDIR=/etc" > config.mk; \
		echo "SBINDIR=/sbin" >> config.mk; \
		echo "LIBEXECDIR=/lib/resolvconf" >> config.mk; \
		echo "VARDIR=/var/run/resolvconf" >> config.mk; \
		echo "MANDIR=$(REMOVE_mandir)" >> config.mk; \
		echo "RCDIR=etc/init.d" >> config.mk; \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	$(TOUCH)
