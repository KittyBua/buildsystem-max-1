################################################################################
#
# luacurl
#
################################################################################

LUACURL_VERSION = git
LUACURL_DIR     = lua-curlv3.git
LUACURL_SOURCE  = lua-curlv3.git
LUACURL_SITE    = https://github.com/Lua-cURL
LUACURL_DEPENDS = bootstrap libcurl lua

LUACURL_MAKE_OPTS = \
	LUA_CMOD=$(TARGET_LIB_DIR)/lua/$(LUA_ABIVERSION) \
	LUA_LMOD=$(TARGET_SHARE_DIR)/lua/$(LUA_ABIVERSION) \
	LIBDIR=$(TARGET_LIB_DIR) \
	LUA_INC=$(TARGET_INCLUDE_DIR) \
	CURL_LIBS="-L$(TARGET_LIB_DIR) -lcurl"

$(D)/luacurl:
	$(call PREPARE)
	$(CHDIR)/$($(PKG)_DIR); \
		$(TARGET_CONFIGURE_ENV) $(MAKE) $(LUACURL_MAKE_OPTS); \
		$(TARGET_CONFIGURE_ENV) $(MAKE)  $(LUACURL_MAKE_OPTS) install
	$(call TARGET_FOLLOWUP)
