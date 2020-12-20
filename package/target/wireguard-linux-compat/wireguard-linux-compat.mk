#
# wireguard-linux-compat
#
WIREGUARD_LINUX_COMPAT_VER    = 1.0.20200908
WIREGUARD_LINUX_COMPAT_DIR    = wireguard-linux-compat-$(WIREGUARD_LINUX_COMPAT_VER)
WIREGUARD_LINUX_COMPAT_SOURCE = wireguard-linux-compat-$(WIREGUARD_LINUX_COMPAT_VER).tar.xz
WIREGUARD_LINUX_COMPAT_SITE   = https://git.zx2c4.com/wireguard-linux-compat/snapshot

WIREGUARD_LINUX_COMPAT_PATCH  = \
	0001-wireguard-linux-compat.patch

$(D)/wireguard-linux-compat: bootstrap kernel libmnl
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches,$(PKG_PATCH)); \
		$(MAKE) -C src all $(KERNEL_MAKEVARS); \
		$(MAKE) -C src install $(KERNEL_MAKEVARS) INSTALL_MOD_PATH=$(TARGET_DIR)
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in wireguard; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/wireguard.conf; \
	done
	make depmod
	$(PKG_REMOVE)
	$(TOUCH)
