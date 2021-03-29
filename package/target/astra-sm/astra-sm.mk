#
# astra-sm
#
ASTRA_SM_VERSION = git
ASTRA_SM_DIR     = astra-sm.git
ASTRA_SM_SOURCE  = astra-sm.git
ASTRA_SM_SITE    = https://gitlab.com/crazycat69
ASTRA_SM_DEPENDS = bootstrap openssl

ASTRA_SM_AUTORECONF = YES

define ASTRA_SM_POST_PATCH
	$(SED) 's:(CFLAGS):(CFLAGS_FOR_BUILD):' $(PKG_BUILD_DIR)/tools/Makefile.am
endef
ASTRA_SM_POST_PATCH_HOOKS = ASTRA_SM_POST_PATCH

ASTRA_SM_CONF_OPTS = \
	--without-lua

astra-sm:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install DESTDIR=$(TARGET_DIR)
	$(REMOVE)
	rm -rf $(addprefix $(TARGET_SHARE_DIR)/,astra)
	$(TOUCH)
