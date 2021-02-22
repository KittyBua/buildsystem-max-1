#
# luaposix
#
LUAPOSIX_VER    = 31
LUAPOSIX_DIR    = luaposix-$(LUAPOSIX_VER)
LUAPOSIX_SOURCE = luaposix-$(LUAPOSIX_VER).tar.gz
LUAPOSIX_SITE   = $(call github,luaposix,luaposix,v$(LUAPOSIX_VER))
LUAPOSIX_DEPS   = bootstrap host-lua lua luaexpat slingshot gnulib

LUAPOSIX_CONF_OPTS = \
	--libdir=$(TARGET_LIB_DIR)/lua/$(LUA_ABIVER) \
	--datadir=$(TARGET_SHARE_DIR)/lua/$(LUA_ABIVER) \
	--mandir=$(TARGET_DIR)/$(REMOVE_mandir) \
	--docdir=$(TARGET_DIR)/$(REMOVE_docdir) \
	--enable-silent-rules

$(D)/luaposix:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		tar -C gnulib --strip=1 -xf $(DL_DIR)/$(GNULIB_SOURCE); \
		tar -C slingshot --strip=1 -xf $(DL_DIR)/$(SLINGSHOT_SOURCE); \
		export LUA=$(HOST_LUA_BINARY); \
		./bootstrap; \
		autoreconf -fi; \
		$(CONFIGURE); \
		$(MAKE); \
		$(MAKE) install
	$(REMOVE)
	$(TOUCH)
