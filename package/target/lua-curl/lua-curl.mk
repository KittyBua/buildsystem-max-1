################################################################################
#
# lua-curl
#
################################################################################

LUA_CURL_VERSION = git
LUA_CURL_DIR = lua-curlv3.git
LUA_CURL_SOURCE = lua-curlv3.git
LUA_CURL_SITE = https://github.com/Lua-cURL

LUA_CURL_DEPENDS = bootstrap libcurl lua

LUA_CURL_MAKE_OPTS = \
	LUA_CMOD=$(TARGET_LIB_DIR)/lua/$(LUA_ABIVERSION) \
	LUA_LMOD=$(TARGET_SHARE_DIR)/lua/$(LUA_ABIVERSION) \
	LIBDIR=$(TARGET_LIB_DIR) \
	LUA_INC=$(TARGET_INCLUDE_DIR) \
	CURL_LIBS="-L$(TARGET_LIB_DIR) -lcurl"

$(D)/lua-curl:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_CONFIGURE_ENV) $(MAKE) $(LUA_CURL_MAKE_OPTS); \
		$(TARGET_CONFIGURE_ENV) $(MAKE) $(LUA_CURL_MAKE_OPTS) install
	$(call TARGET_FOLLOWUP)
