#
# wireguard-tools
#
WIREGUARD_TOOLS_VER    = 1.0.20200319
WIREGUARD_TOOLS_DIR    = wireguard-tools-$(WIREGUARD_TOOLS_VER)
WIREGUARD_TOOLS_SOURCE = wireguard-tools-$(WIREGUARD_TOOLS_VER).tar.xz
WIREGUARD_TOOLS_URL    = https://git.zx2c4.com/wireguard-tools/snapshot

WIREGUARD_TOOLS_MAKE_OPTS = WITH_SYSTEMDUNITS=no WITH_BASHCOMPLETION=yes WITH_WGQUICK=yes

$(D)/wireguard-tools: bootstrap kernel libmnl openresolv
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR)/src; \
		$(BUILD_ENV) \
		$(MAKE) all     $(WIREGUARD_TOOLS_MAKE_OPTS) PREFIX=/usr; \
		$(MAKE) install $(WIREGUARD_TOOLS_MAKE_OPTS) DESTDIR=$(TARGET_DIR) MANDIR=/.remove
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
