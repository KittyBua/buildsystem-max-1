################################################################################
#
# wireguard-linux-compat
#
################################################################################

WIREGUARD_LINUX_COMPAT_VERSION = 1.0.20210219
WIREGUARD_LINUX_COMPAT_DIR     = wireguard-linux-compat-$(WIREGUARD_LINUX_COMPAT_VERSION)
WIREGUARD_LINUX_COMPAT_SOURCE  = wireguard-linux-compat-$(WIREGUARD_LINUX_COMPAT_VERSION).tar.xz
WIREGUARD_LINUX_COMPAT_SITE    = https://git.zx2c4.com/wireguard-linux-compat/snapshot
WIREGUARD_LINUX_COMPAT_DEPENDS = bootstrap kernel libmnl

define WIREGUARD_LINUX_COMPAT_INSTALL_FILES
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in wireguard; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/wireguard.conf; \
	done
	$(LINUX_RUN_DEPMOD)
endef
WIREGUARD_LINUX_COMPAT_POST_INSTALL_TARGET_HOOKS += WIREGUARD_LINUX_COMPAT_INSTALL_FILES

$(D)/wireguard-linux-compat:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) -C src $(KERNEL_MAKE_VARS); \
		$(MAKE) -C src install $(KERNEL_MAKE_VARS) INSTALL_MOD_PATH=$(TARGET_DIR)
	$(call TARGET_FOLLOWUP)
