################################################################################
#
# luaposix
#
################################################################################

LUAPOSIX_VERSION = 31
LUAPOSIX_DIR     = luaposix-$(LUAPOSIX_VERSION)
LUAPOSIX_SOURCE  = luaposix-$(LUAPOSIX_VERSION).tar.gz
LUAPOSIX_SITE    = $(call github,luaposix,luaposix,v$(LUAPOSIX_VERSION))
LUAPOSIX_DEPENDS = bootstrap host-lua lua luaexpat slingshot gnulib

LUAPOSIX_AUTORECONF = YES

LUAPOSIX_CONF_ENV = \
	LUA=$(HOST_LUA_BINARY)

LUAPOSIX_CONF_OPTS = \
	--libdir=$(TARGET_LIB_DIR)/lua/$(LUA_ABIVERSION) \
	--datadir=$(TARGET_SHARE_DIR)/lua/$(LUA_ABIVERSION) \
	--mandir=$(TARGET_DIR)$(REMOVE_mandir) \
	--docdir=$(TARGET_DIR)$(REMOVE_docdir)

define LUAPOSIX_UNPACK_GNULIB
	tar -C $(PKG_BUILD_DIR)/gnulib --strip=1 -xf $(DL_DIR)/$(GNULIB_SOURCE)
endef
LUAPOSIX_POST_PATCH_HOOKS += LUAPOSIX_UNPACK_GNULIB

define LUAPOSIX_UNPACK_SLINGSHOT
	tar -C $(PKG_BUILD_DIR)/slingshot --strip=1 -xf $(DL_DIR)/$(SLINGSHOT_SOURCE)
endef
LUAPOSIX_POST_PATCH_HOOKS += LUAPOSIX_UNPACK_SLINGSHOT

$(D)/luaposix:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		./bootstrap; \
		$(TARGET_CONFIGURE); \
		$(MAKE); \
		$(MAKE) install
	$(call TARGET_FOLLOWUP)
