#
# luacurl
#
LUACURL_VERSION = git
LUACURL_DIR     = lua-curlv3.git
LUACURL_SOURCE  = lua-curlv3.git
LUACURL_SITE    = https://github.com/Lua-cURL
LUACURL_DEPENDS = bootstrap libcurl lua

$(D)/luacurl:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(MAKE) CC=$(TARGET_CC) LDFLAGS="-L$(TARGET_LIB_DIR)" \
			LIBDIR=$(TARGET_LIB_DIR) \
			LUA_INC=$(TARGET_INCLUDE_DIR); \
		$(MAKE) install LUA_CMOD=$(TARGET_LIB_DIR)/lua/$(LUA_ABIVERSION) LUA_LMOD=$(TARGET_SHARE_DIR)/lua/$(LUA_ABIVERSION)
	$(call TARGET_FOLLOWUP)
