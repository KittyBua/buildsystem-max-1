#
# lua
#
LUA_VER    = 5.2.4
LUA_ABIVER = $(basename $(LUA_VER))
LUA_DIR    = lua-$(LUA_VER)
LUA_SOURCE = lua-$(LUA_VER).tar.gz
LUA_URL    = https://www.lua.org/ftp

LUA_PATCH  = \
	0001-fix-lua-root.patch \
	0002-remove-readline.patch \
	0003-shared-library.patch \
	0004-lua-pc.patch \
	0005-crashfix.patch

$(D)/lua: bootstrap host-lua ncurses
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(UNTAR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(call apply_patches, $(PKG_PATCH)); \
		$(MAKE) linux \
			PKG_VERSION=$(LUA_VER) \
			$(MAKE_OPTS) \
			AR="$(TARGET_AR) rcu" \
			LDFLAGS="$(TARGET_LDFLAGS)" \
			; \
		$(MAKE) INSTALL_TOP=$(TARGET_DIR)/usr \
			INSTALL_DATA="cp -d" \
			INSTALL_MAN=$(TARGET_DIR)/.remove install \
			TO_LIB="liblua.so liblua.so.$(LUA_ABIVER) liblua.so.$(LUA_VER)"
	$(INSTALL_DATA) -D $(BUILD_DIR)/lua-$(LUA_VER)/etc/lua.pc $(PKG_CONFIG_PATH)/lua.pc
	rm -rf $(addprefix $(TARGET_DIR)/bin/,luac)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
