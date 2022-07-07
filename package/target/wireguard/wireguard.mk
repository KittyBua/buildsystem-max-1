################################################################################
#
# wireguard
#
################################################################################

WIREGUARD_VERSION = 0.0.20191212
WIREGUARD_DIR = WireGuard-$(WIREGUARD_VERSION)
WIREGUARD_SOURCE = WireGuard-$(WIREGUARD_VERSION).tar.xz
WIREGUARD_SITE = https://git.zx2c4.com/WireGuard/snapshot

WIREGUARD_DEPENDS = bootstrap kernel libmnl openresolv

WIREGUARD_MAKE_OPTS = WITH_SYSTEMDUNITS=no WITH_BASHCOMPLETION=yes WITH_WGQUICK=yes

define WIREGUARD_INSTALL_FILES
	mkdir -p ${TARGET_DIR}/etc/modules-load.d
	for i in wireguard; do \
		echo $$i >> ${TARGET_DIR}/etc/modules-load.d/wireguard.conf; \
	done
	$(LINUX_RUN_DEPMOD)
endef
WIREGUARD_POST_FOLLOWUP_HOOKS += WIREGUARD_INSTALL_FILES

$(D)/wireguard:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_CONFIGURE_ENV) \
		$(MAKE) -C src $(KERNEL_MAKE_VARS) $(WIREGUARD_MAKE_OPTS) PREFIX=/usr; \
		$(MAKE) -C src install $(KERNEL_MAKE_VARS) $(WIREGUARD_MAKE_OPTS) INSTALL_MOD_PATH=$(TARGET_DIR) DESTDIR=$(TARGET_DIR) MANDIR=$(REMOVE_mandir)
	$(call TARGET_FOLLOWUP)
