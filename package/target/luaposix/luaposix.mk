#
# luaposix
#
LUAPOSIX_VERSION = 31
LUAPOSIX_DIR     = luaposix-$(LUAPOSIX_VERSION)
LUAPOSIX_SOURCE  = luaposix-$(LUAPOSIX_VERSION).tar.gz
LUAPOSIX_SITE    = $(call github,luaposix,luaposix,v$(LUAPOSIX_VERSION))
LUAPOSIX_DEPENDS = bootstrap host-lua lua luaexpat slingshot gnulib

LUAPOSIX_AUTORECONF = YES

LUAPOSIX_CONF_OPTS = \
	--libdir=$(TARGET_LIB_DIR)/lua/$(LUA_ABIVERSION) \
	--datadir=$(TARGET_SHARE_DIR)/lua/$(LUA_ABIVERSION) \
	--mandir=$(TARGET_DIR)/$(REMOVE_mandir) \
	--docdir=$(TARGET_DIR)/$(REMOVE_docdir) \
	--enable-silent-rules

luaposix:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		tar -C gnulib --strip=1 -xf $(DL_DIR)/$(GNULIB_SOURCE); \
		tar -C slingshot --strip=1 -xf $(DL_DIR)/$(SLINGSHOT_SOURCE); \
		./bootstrap; \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install
	$(REMOVE)
	$(TOUCH)
