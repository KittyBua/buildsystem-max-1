#
# procps-ng
#
PROCPS_NG_VER    = 3.3.16
PROCPS_NG_DIR    = procps-ng-$(PROCPS_NG_VER)
PROCPS_NG_SOURCE = procps-ng-$(PROCPS_NG_VER).tar.xz
PROCPS_NG_SITE   = http://sourceforge.net/projects/procps-ng/files/Production

PROCPS_NG_CONF_OPTS = \
	--docdir=$(REMOVE_docdir) \
	--bindir=$(base_bindir) \
	--sbindir=$(base_sbindir) \
	--enable-skill \
	--disable-modern-top \
	--without-systemd

PROCPS_NG_BIN = \
	free pgrep pkill pmap pwdx slabtop skill snice tload top uptime vmstat w

$(D)/procps-ng: bootstrap ncurses
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		export ac_cv_func_malloc_0_nonnull=yes; \
		export ac_cv_func_realloc_0_nonnull=yes; \
		autoreconf -fi; \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	for i in $(PROCPS_NG_BIN); do \
		mv $(TARGET_DIR)/bin/$$i $(TARGET_DIR)/usr/bin/$$i; \
	done
	$(INSTALL_DATA) $(PKG_FILES_DIR)/sysctl.conf $(TARGET_DIR)/etc/sysctl.conf
	$(REWRITE_LIBTOOL_LA)
	$(PKG_REMOVE)
	$(TOUCH)
