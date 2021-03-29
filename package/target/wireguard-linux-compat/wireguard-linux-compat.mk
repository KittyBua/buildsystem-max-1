#
# wireguard-linux-compat
#
WIREGUARD_LINUX_COMPAT_VERSION = 1.0.20210219
WIREGUARD_LINUX_COMPAT_DIR     = wireguard-linux-compat-$(WIREGUARD_LINUX_COMPAT_VERSION)
WIREGUARD_LINUX_COMPAT_SOURCE  = wireguard-linux-compat-$(WIREGUARD_LINUX_COMPAT_VERSION).tar.xz
WIREGUARD_LINUX_COMPAT_SITE    = https://git.zx2c4.com/wireguard-linux-compat/snapshot
WIREGUARD_LINUX_COMPAT_DEPENDS = bootstrap kernel libmnl

wireguard-linux-compat:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(MAKE) -C src $(KERNEL_MAKEVARS); \
		$(MAKE) -C src install $(KERNEL_MAKEVARS) INSTALL_MOD_PATH=$(TARGET_DIR)
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in wireguard; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/wireguard.conf; \
	done
	$(LINUX_RUN_DEPMOD)
	$(REMOVE)
	$(TOUCH)
