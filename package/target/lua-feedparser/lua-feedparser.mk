#
# lua-feedparser
#
LUA_FEEDPARSER_VER    = 0.71
LUA_FEEDPARSER_DIR    = lua-feedparser-$(LUA_FEEDPARSER_VER)
LUA_FEEDPARSER_SOURCE = lua-feedparser-$(LUA_FEEDPARSER_VER).tar.gz
LUA_FEEDPARSER_GIT    = $(LUA_FEEDPARSER_VER).tar.gz -O $(DL_DIR)/$(LUA_FEEDPARSER_SOURCE)
LUA_FEEDPARSER_SITE   = https://github.com/slact/lua-feedparser/archive

$(D)/lua-feedparser: bootstrap lua luasocket luaexpat
	$(START_BUILD)
	$(call PKG_DOWNLOAD,$(LUA_FEEDPARSER_GIT))
	$(PKG_REMOVE)
	$(PKG_UNPACK)
	$(PKG_CHDIR); \
		sed -i -e "s/^PREFIX.*//" -e "s/^LUA_DIR.*//" Makefile ; \
		$(BUILD_ENV) $(MAKE) install LUA_DIR=$(TARGET_SHARE_DIR)/lua/$(LUA_ABIVER)
	$(PKG_REMOVE)
	$(TOUCH)
