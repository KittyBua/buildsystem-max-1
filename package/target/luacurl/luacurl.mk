#
# luacurl
#
LUACURL_VER    = git
LUACURL_DIR    = lua-curlv3.git
LUACURL_SOURCE = lua-curlv3.git
LUACURL_URL    = git://github.com/Lua-cURL

$(D)/luacurl: bootstrap libcurl lua
	$(START_BUILD)
	$(call DOWNLOAD,$(PKG_SOURCE))
	$(REMOVE)/$(PKG_DIR)
	$(CPDIR)/$(PKG_SOURCE)
	$(CHDIR)/$(PKG_DIR); \
		$(MAKE) CC=$(TARGET_CC) LDFLAGS="-L$(TARGET_LIB_DIR)" \
			LIBDIR=$(TARGET_LIB_DIR) \
			LUA_INC=$(TARGET_INCLUDE_DIR); \
		$(MAKE) install LUA_CMOD=$(TARGET_LIB_DIR)/lua/$(LUA_ABIVER) LUA_LMOD=$(TARGET_SHARE_DIR)/lua/$(LUA_ABIVER)
	$(REMOVE)/$(PKG_DIR)
	$(TOUCH)
