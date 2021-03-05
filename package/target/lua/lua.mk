#
# lua
#
LUA_VER    = 5.2.4
LUA_ABIVER = $(basename $(LUA_VER))
LUA_DIR    = lua-$(LUA_VER)
LUA_SOURCE = lua-$(LUA_VER).tar.gz
LUA_SITE   = https://www.lua.org/ftp
LUA_DEPS   = bootstrap host-lua ncurses

$(D)/lua:
	$(START_BUILD)
	$(REMOVE)
	$(call DOWNLOAD,$($(PKG)_SOURCE))
	$(call EXTRACT,$(BUILD_DIR))
	$(APPLY_PATCHES)
	$(CD_BUILD_DIR); \
		$(MAKE) linux \
			BUILDMODE=dynamic \
			PKG_VERSION=$(LUA_VER) \
			$(MAKE_OPTS) \
			AR="$(TARGET_AR) rcu" \
			LDFLAGS="$(TARGET_LDFLAGS)" \
			; \
		$(MAKE) INSTALL_TOP=$(TARGET_DIR)/usr \
			INSTALL_MAN=$(TARGET_DIR)$(REMOVE_mandir) install \
			; \
		$(INSTALL_DATA) -D $(BUILD_DIR)/lua-$(LUA_VER)/etc/lua.pc \
			$(PKG_CONFIG_PATH)/lua.pc
	$(REMOVE)
	rm -rf $(addprefix $(TARGET_DIR)/bin/,luac)
	$(TOUCH)
