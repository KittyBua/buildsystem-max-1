#
# wireguard
#
WIREGUARD_VER    = 0.0.20191212
WIREGUARD_DIR    = WireGuard-$(WIREGUARD_VER)
WIREGUARD_SOURCE = WireGuard-$(WIREGUARD_VER).tar.xz
WIREGUARD_SITE   = https://git.zx2c4.com/WireGuard/snapshot
WIREGUARD_DEPS   = bootstrap kernel libmnl openresolv

WIREGUARD_MAKE_OPTS = WITH_SYSTEMDUNITS=no WITH_BASHCOMPLETION=yes WITH_WGQUICK=yes

$(D)/wireguard:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(TARGET_CONFIGURE_ENV) \
		$(MAKE) -C src $(KERNEL_MAKEVARS) $(WIREGUARD_MAKE_OPTS) PREFIX=/usr; \
		$(MAKE) -C src install $(KERNEL_MAKEVARS) $(WIREGUARD_MAKE_OPTS) INSTALL_MOD_PATH=$(TARGET_DIR) DESTDIR=$(TARGET_DIR) MANDIR=$(REMOVE_mandir)
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in wireguard; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/wireguard.conf; \
	done
	$(LINUX_RUN_DEPMOD)
	$(REMOVE)
	$(TOUCH)
