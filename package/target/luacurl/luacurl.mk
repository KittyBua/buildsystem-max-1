#
# luacurl
#
LUACURL_VER    = git
LUACURL_DIR    = lua-curlv3.git
LUACURL_SOURCE = lua-curlv3.git
LUACURL_SITE   = git://github.com/Lua-cURL

$(D)/luacurl: bootstrap libcurl lua
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(PKG_SOURCE))
	$(PKG_REMOVE)
	$(call PKG_UNPACK,$(BUILD_DIR))
	$(PKG_CHDIR); \
		$(MAKE) CC=$(TARGET_CC) LDFLAGS="-L$(TARGET_LIB_DIR)" \
			LIBDIR=$(TARGET_LIB_DIR) \
			LUA_INC=$(TARGET_INCLUDE_DIR); \
		$(MAKE) install LUA_CMOD=$(TARGET_LIB_DIR)/lua/$(LUA_ABIVER) LUA_LMOD=$(TARGET_SHARE_DIR)/lua/$(LUA_ABIVER)
	$(PKG_REMOVE)
	$(TOUCH)
