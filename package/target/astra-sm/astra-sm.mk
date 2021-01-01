#
# astra-sm
#
ASTRA_SM_VER    = git
ASTRA_SM_DIR    = astra-sm.git
ASTRA_SM_SOURCE = astra-sm.git
ASTRA_SM_SITE   = https://gitlab.com/crazycat69

define ASTRA_SM_POST_PATCH
	$(SED) 's:(CFLAGS):(CFLAGS_FOR_BUILD):' $(PKG_BUILD_DIR)/tools/Makefile.am
endef
ASTRA_SM_POST_PATCH_HOOKS = ASTRA_SM_POST_PATCH

ASTRA_SM_CONF_OPTS = \
	--without-lua

$(D)/astra-sm: bootstrap openssl
	$(START_BUILD)
	$(PKG_REMOVE)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_APPLY_PATCHES)
	$(PKG_CHDIR); \
		autoreconf -fi $(SILENT_OPT); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,astra)
	$(PKG_REMOVE)
	$(TOUCH)
