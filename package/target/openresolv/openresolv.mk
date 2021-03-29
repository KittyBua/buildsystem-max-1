#
# openresolv
#
OPENRESOLV_VERSION = 3.12.0
OPENRESOLV_DIR     = openresolv-openresolv-$(OPENRESOLV_VERSION)
OPENRESOLV_SOURCE  = openresolv-$(OPENRESOLV_VERSION).tar.gz
OPENRESOLV_SITE    = https://github.com/rsmarples/openresolv/archive
OPENRESOLV_DEPENDS = bootstrap

openresolv:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
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
