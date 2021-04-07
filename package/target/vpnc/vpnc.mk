#
# vpnc
#
VPNC_VERSION = 0.5.3r550-2jnpr1
VPNC_DIR     = vpnc-$(VPNC_VERSION)
VPNC_SOURCE  = vpnc-$(VPNC_VERSION).tar.gz
VPNC_SITE    = $(call github,ndpgroup,vpnc,$(VPNC_VERSION))
VPNC_DEPENDS = bootstrap openssl libgcrypt libgpg-error

$(D)/vpnc:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(TARGET_CONFIGURE_OPTS) \
		$(MAKE); \
		$(MAKE) \
			install DESTDIR=$(TARGET_DIR) \
			PREFIX=/usr \
			MANDIR=$(REMOVE_mandir) \
			DOCDIR=$(REMOVE_docdir)
	$(REMOVE)
	$(TOUCH)
