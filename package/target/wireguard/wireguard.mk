#
# wireguard
#
WIREGUARD_VER    = 0.0.20191212
WIREGUARD_DIR    = WireGuard-$(WIREGUARD_VER)
WIREGUARD_SOURCE = WireGuard-$(WIREGUARD_VER).tar.xz
WIREGUARD_SITE   = https://git.zx2c4.com/WireGuard/snapshot

WIREGUARD_MAKE_OPTS = WITH_SYSTEMDUNITS=no WITH_BASHCOMPLETION=yes WITH_WGQUICK=yes

$(D)/wireguard: bootstrap kernel libmnl openresolv
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(BUILD_ENV) \
		$(MAKE) -C src $(KERNEL_MAKEVARS) $(WIREGUARD_MAKE_OPTS) PREFIX=/usr; \
		$(MAKE) -C src install $(KERNEL_MAKEVARS) $(WIREGUARD_MAKE_OPTS) INSTALL_MOD_PATH=$(TARGET_DIR) DESTDIR=$(TARGET_DIR) MANDIR=$(REMOVE_mandir)
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in wireguard; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/wireguard.conf; \
	done
	$(LINUX_RUN_DEPMOD)
	$(PKG_REMOVE)
	$(TOUCH)
