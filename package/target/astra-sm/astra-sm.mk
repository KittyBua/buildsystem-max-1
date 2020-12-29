#
# astra-sm
#
ASTRA_SM_VER    = git
ASTRA_SM_DIR    = astra-sm.git
ASTRA_SM_SOURCE = astra-sm.git
ASTRA_SM_SITE   = https://gitlab.com/crazycat69

ASTRA_SM_PATCH = \
	0001-version.patch \
	0002-undef_dvb_net.patch

ASTRA_SM_CONF_OPTS = \
	--without-lua

$(D)/astra-sm: bootstrap openssl
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(call apply_patches,$(PKG_PATCH)); \
		autoreconf -fi $(SILENT_OPT); \
		$(SED) 's:(CFLAGS):(CFLAGS_FOR_BUILD):' tools/Makefile.am; \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,astra)
	$(PKG_REMOVE)
	$(TOUCH)
