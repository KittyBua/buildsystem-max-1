#
# wireguard
#
WIREGUARD_VER    = 0.0.20191212
WIREGUARD_DIR    = WireGuard-$(WIREGUARD_VER)
WIREGUARD_SOURCE = WireGuard-$(WIREGUARD_VER).tar.xz
WIREGUARD_URL    = https://git.zx2c4.com/WireGuard/snapshot

WIREGUARD_PATCH = \
	0001-wireguard.patch

WIREGUARD_MAKE_OPTS = WITH_SYSTEMDUNITS=no WITH_BASHCOMPLETION=yes WITH_WGQUICK=yes

$(D)/wireguard: bootstrap kernel libmnl openresolv
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR)/src; \
		$(call apply_patches, $(PKG_PATCH)); \
		$(BUILD_ENV) \
		$(MAKE) all     $(KERNEL_MAKEVARS) $(WIREGUARD_MAKE_OPTS) PREFIX=/usr; \
		$(MAKE) install $(KERNEL_MAKEVARS) $(WIREGUARD_MAKE_OPTS) INSTALL_MOD_PATH=$(TARGET_DIR) DESTDIR=$(TARGET_DIR) MANDIR=/.remove
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in wireguard; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/wireguard.conf; \
	done
	make depmod
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
