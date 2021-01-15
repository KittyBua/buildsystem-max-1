#
# vpnc
#
VPNC_VER    = 0.5.3r550-2jnpr1
VPNC_DIR    = vpnc-$(VPNC_VER)
VPNC_SOURCE = vpnc-$(VPNC_VER).tar.gz
VPNC_SITE   = $(call github,ndpgroup,vpnc,$(VPNC_VER))
VPNC_DEPS   = bootstrap openssl libgcrypt libgpg-error

$(D)/vpnc:
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		$(BUILD_ENV) \
		$(MAKE); \
		$(MAKE) \
			install DESTDIR=$(TARGET_DIR) \
			PREFIX=/usr \
			MANDIR=$(REMOVE_mandir) \
			DOCDIR=$(REMOVE_docdir)
	$(PKG_REMOVE)
	$(TOUCH)
