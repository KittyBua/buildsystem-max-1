#
# vpnc
#
VPNC_VER    = 0.5.3r550-2jnpr1
VPNC_DIR    = vpnc-$(VPNC_VER)
VPNC_SOURCE = vpnc-$(VPNC_VER).tar.gz
VPNC_GIT    = $(VPNC_VER).tar.gz -O $(DL_DIR)/$(VPNC_SOURCE)
VPNC_URL    = https://github.com/ndpgroup/vpnc/archive

VPNC_PATCH  = \
	0001-Makefile-allow-to-override-the-PREFIX-variable.patch \
	0002-nomanual.patch \
	0002-Makefile-allow-to-override-the-version.patch \
	0003-Makefile-allow-passing-custom-CFLAGS-CPPFLAGS.patch \
	0004-Makefile-provide-an-option-to-not-build-manpages.patch \
	0005-Makefile-allow-passing-a-custom-path-to-libgcrypt-co.patch \
	0006-config.c-Replace-deprecated-SUSv3-functions-with-POS.patch \
	0007-sysdep.h-don-t-assume-error.h-is-available-on-all-Li.patch \
	0008-sysdep.c-don-t-include-linux-if_tun.h-on-Linux.patch \
	0009-config.c-add-missing-sys-ttydefaults.h-include.patch

$(D)/vpnc: bootstrap openssl libgcrypt libgpg-error
	$(START_BUILD)
	$(call DOWNLOAD,$(VPNC_GIT))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(BUILD_ENV) \
		$(MAKE); \
		$(MAKE) \
			install DESTDIR=$(TARGET_DIR) \
			PREFIX=/usr \
			MANDIR=/.remove \
			DOCDIR=/.remove
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
