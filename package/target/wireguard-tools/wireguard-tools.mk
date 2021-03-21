#
# wireguard-tools
#
WIREGUARD_TOOLS_VERSION = 1.0.20210223
WIREGUARD_TOOLS_DIR     = wireguard-tools-$(WIREGUARD_TOOLS_VERSION)
WIREGUARD_TOOLS_SOURCE  = wireguard-tools-$(WIREGUARD_TOOLS_VERSION).tar.xz
WIREGUARD_TOOLS_SITE    = https://git.zx2c4.com/wireguard-tools/snapshot
WIREGUARD_TOOLS_DEPENDS = bootstrap kernel libmnl openresolv

WIREGUARD_TOOLS_MAKE_OPTS = \
	WITH_SYSTEMDUNITS=no \
	WITH_BASHCOMPLETION=yes \
	WITH_WGQUICK=yes

$(D)/wireguard-tools:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(TARGET_CONFIGURE_ENV) \
		$(MAKE) -C src $(WIREGUARD_TOOLS_MAKE_OPTS) PREFIX=/usr; \
		$(MAKE) -C src install $(WIREGUARD_TOOLS_MAKE_OPTS) DESTDIR=$(TARGET_DIR) MANDIR=$(REMOVE_mandir)
	$(REMOVE)
	$(TOUCH)
