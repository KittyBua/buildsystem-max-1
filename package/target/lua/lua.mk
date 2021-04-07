#
# lua
#
LUA_VERSION    = 5.2.4
LUA_ABIVERSION = $(basename $(LUA_VERSION))
LUA_DIR        = lua-$(LUA_VERSION)
LUA_SOURCE     = lua-$(LUA_VERSION).tar.gz
LUA_SITE       = https://www.lua.org/ftp
LUA_DEPENDS    = bootstrap host-lua ncurses

$(D)/lua:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(MAKE) linux \
			BUILDMODE=dynamic \
			PKG_VERSION=$(LUA_VERSION) \
			CC=$(TARGET_CC) \
			CPPFLAGS="$(TARGET_CPPFLAGS) -fPIC" \
			LDFLAGS="-L$(TARGET_LIB_DIR)" \
			AR="$(TARGET_AR) rcu"; \
		$(MAKE) install \
			INSTALL_TOP=$(TARGET_DIR)/usr \
			INSTALL_MAN=$(TARGET_DIR)$(REMOVE_mandir); \
		$(INSTALL_DATA) -D $(PKG_BUILD_DIR)/lua.pc $(PKG_CONFIG_PATH)/lua.pc
	$(REMOVE)
	rm -rf $(addprefix $(TARGET_DIR)/bin/,luac)
	$(TOUCH)
